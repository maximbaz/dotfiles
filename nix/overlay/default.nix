{ pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      input-fonts = super.input-fonts.overrideAttrs (_old: {
        src = super.fetchzip {
          # This URL is too long for fetchzip, and returns non-reproducible zips with new sha256 every time ☹️
          # url = "https://input.djr.com/build/?customize&fontSelection=fourStyleFamily&regular=InputMonoNarrow-Regular&italic=InputMonoNarrow-Italic&bold=InputMonoNarrow-Bold&boldItalic=InputMonoNarrow-BoldItalic&a=0&g=0&i=serifs_round&l=serifs_round&zero=slash&asterisk=height&braces=0&preset=default&line-height=1.1&accept=I+do&email=";
          url = "https://maximbaz.com/input-fonts.zip";
          sha256 = "09qfb3h2s1dlf6kn8d4f5an6jhfpihn02zl02sjj26zgclrp6blc";
          stripRoot = false;
        };
      });

      signal-desktop-from-src =
        let
          version = "7.14.0";

          ringrtcPrebuild = super.fetchurl {
            # version is found in signal-desktop's package.json as "@signalapp/ringrtc"
            url = "https://build-artifacts.signal.org/libraries/ringrtc-desktop-build-v2.44.0.tar.gz";
            hash = "sha256-pxfwfEpz6kOlvNcAmnCcwUncKAql8dDPnWUcDV6rWag=";
          };
          sqlcipherTarball = super.fetchurl {
            # this is a dependency of better-sqlite3.
            # version/url is found in <repo:https://github.com/signalapp/better-sqlite3:deps/download.js>
            # - checkout the better-sqlite3 tag which matches signal-dekstop's package.json "@signalapp/better-sqlite3" key.
            url = "https://build-artifacts.signal.org/desktop/sqlcipher-4.5.5-fts5-fix--3.0.7--0.2.1-ef53ea45ed92b928ecfd33c552d8d405263e86e63dec38e1ec63e1b0193b630b.tar.gz";
            hash = "sha256-71PqRe2SuSjs/TPFUtjUBSY+huY97Djh7GPhsBk7Yws=";
          };
          # TODO: possibly i could instead use nodejs-slim (npm-less nodejs)
          # mkNodeJs = pkgs: pkgs.nodejs_20.overrideAttrs (upstream:
          #   let
          #     # build with the same nodejs upstream expects in package.json (it will error if the version here is incorrect)
          #     version = "20.9.0";
          #     hash = "sha256-oj2WgQq/BFVCazSdR85TEPMwlbe8BXG5zFEPSBw6RRk=";
          #   in {
          #     inherit version;
          #     src = fetchurl {
          #       url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
          #       inherit hash;
          #     };
          #   }
          # );
          mkNodeJs = pkgs: pkgs.nodejs;

          # signal-fts5-extension = callPackage ./fts5-extension { };
          # bettersqlitePatch = substituteAll {
          #   # this patch does more than just use the system sqlcipher.
          #   # it also tells bettersqlite to link against its needed runtime dependencies,
          #   # since there's a few statically linked things which aren't called out.
          #   # it also tells bettersqlite not to download sqlcipher when we `npm rebuild`
          #   src = ./signal-desktop/bettersqlite-use-system-sqlcipher.patch;
          #   inherit sqlcipher;
          #   inherit (nodejs') libv8;
          #   signal_fts5_extension = signal-fts5-extension;
          # };

          src = super.fetchFromGitHub {
            owner = "signalapp";
            repo = "Signal-Desktop";
            leaveDotGit = true; # signal calculates the release date via `git`
            rev = "v${version}";
            hash = "sha256-r6C5f3YlntC3m3HzG1sPPl4mwKYtxD+lwYNzmIuG6l8=";
          };
          yarnOfflineCache = super.fetchYarnDeps {
            yarnLock = "${src}/yarn.lock";
            hash = "sha256-fAnAnpY+23T+u+HAK230/ebUhJQ+KYHK328HLL49qZA=";
          };

          nodejs' = mkNodeJs pkgs;
          buildNodejs = mkNodeJs super.buildPackages;

          buildYarn = super.buildPackages.yarn.override { nodejs = buildNodejs; };

          # note that `package.json` locks the electron version, but we seem to not be strictly beholden to that.
          # prefer to use the same electron version as everywhere else, and a `-bin` version to avoid 4hr rebuilds.
          # the non-bin varieties *seem* to ship the wrong `electron.headers` property.
          # - maybe they can work if i manually DL and ship the corresponding headers
          electron' = super.electron-bin;

          buildNpmArch = if super.stdenv.buildPlatform.isAarch64 then "arm64" else "x64";
          hostNpmArch = if super.stdenv.hostPlatform.isAarch64 then "arm64" else "x64";
          crossNpmArchExt = "-${hostNpmArch}"; # if buildNpmArch == hostNpmArch then "" else "-${hostNpmArch}";
        in
        super.stdenv.mkDerivation rec {
          pname = "signal-desktop-from-src";
          inherit src version;

          patches = [
            # ./signal-desktop/debug.patch
            # fix bug that signal launches in the background on wayland
            # - <https://github.com/signalapp/Signal-Desktop/issues/6368>
            # - without this, signal can be started with `signal-desktop & ; sleep 5; signal-desktop`
            #   - the second instance wakes the first one, and then exits
            ./signal-desktop/show-on-launch.patch
            ./signal-desktop/no-mac-screen-share.patch
          ];

          postPatch = ''
            # unpin nodejs. i should probably *try* to keep these vaguely in sync, but it seems to work decently with these out of sync too (at least, if the major versions match?)
            sed -i 's/"node": .*/"node": "${nodejs'.version}"/' package.json

            # fixes build failure:
            # > Fusing electron at /build/source/release/linux-unpacked/signal-desktop inspect-arguments=false
            # >   ⨯ EACCES: permission denied, open '/build/source/release/linux-unpacked/signal-desktop'  failedTask=build stackTrace=Error: EACCES: permission denied, open '/build/source/release/linux-unpacked/signal-desktop'
            # electron "fusing" (electron.flipFuses) seems to be configuring which functionality electron will support at runtime.
            # notably: ELECTRON_RUN_AS_NODE, cookie encryption, NODE_OPTIONS env var, --inspect-* CLI args, app.asar validation
            # skipping the fuse process seems relatively inconsequential
            substituteInPlace ts/scripts/after-pack.ts \
              --replace-fail 'await fuseElectron' '//await fuseElectron'
          '';

          nativeBuildInputs = with pkgs; [
            autoPatchelfHook
            fixup_yarn_lock
            git # to calculate build date
            gnused
            makeShellWrapper
            buildNodejs
            python3
            wrapGAppsHook
            buildYarn
          ];

          buildInputs = with pkgs; [
            alsa-lib
            at-spi2-atk
            at-spi2-core
            atk
            cups
            electron'
            flac
            gdk-pixbuf
            gtk3
            libpulseaudio
            libwebp
            libxslt
            mesa # for libgbm
            nodejs' # to patch in the runtime
            nspr
            nss
            pango
            # so that bettersqlite may link against sqlcipher (see patch)
            # but i don't know if it actually needs to. just copied this from alpine.
            # sqlcipher
          ];

          env.yarnOfflineCache = yarnOfflineCache;
          # env.SIGNAL_ENV = "production";
          # env.NODE_ENV = "production";
          # env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

          dontWrapGApps = true;

          # NIX_DEBUG = 6;

          configurePhase = ''
            runHook preConfigure

            # XXX: Signal does not let clients connect if they're running a version that's > 90d old.
            # to calculate the build date, it uses SOURCE_DATE_EPOCH (if set), else `git log`.
            # nixpkgs sets SOURCE_DATE_EPOCH to 1980/01/01 by default, so unset it so Signal falls back to git date.
            # see: Signal-Desktop/ts/scripts/get-expire-time.ts
            export SOURCE_DATE_EPOCH=

            export HOME=$NIX_BUILD_TOP
            yarn config --offline set yarn-offline-mirror $yarnOfflineCache
            fixup_yarn_lock yarn.lock

            # prevent any attempt at downloading nodejs C headers
            # see: <https://www.electronjs.org/docs/latest/tutorial/using-native-node-modules>
            tar xzf ${electron'.headers}
            export npm_config_nodedir=$(pwd)/node_headers

            export npm_config_arch=${buildNpmArch}
            export npm_config_target_arch=${hostNpmArch}

            # optional flags:  --no-progress --non-interactive
            # yarn install creates the node_modules/ directory
            # --ignore-scripts tells yarn to not run the "install" or "postinstall" commands mentioned in dependencies' package.json
            #   since many of those require network access
            yarn install --offline --frozen-lockfile --ignore-scripts
            patchShebangs node_modules/
            patchShebangs --build --update node_modules/{bufferutil/node_modules/node-gyp-build/,node-gyp-build,utf-8-validate/node_modules/node-gyp-build}
            # patch these out to remove a runtime reference back to the build bash
            # (better, perhaps, would be for these build scripts to not be included in the asar...)
            sed -i 's:#!.*/bin/bash:#!/bin/sh:g' node_modules/@swc/helpers/scripts/gen.sh
            sed -i 's:#!.*/bin/bash:#!/bin/sh:g' node_modules/@swc/helpers/scripts/generator.sh
            substituteInPlace node_modules/dashdash/etc/dashdash.bash_completion.in --replace-fail '#!/bin/bash' '#!/bin/sh'

            set -x

            # provide necessecities which were skipped as part of --ignore-scripts
            cp ${ringrtcPrebuild} node_modules/@signalapp/ringrtc/scripts/prebuild.tar.gz
            pushd node_modules/@signalapp/ringrtc/
              tar -xzf ./scripts/prebuild.tar.gz
            popd

            cp ${sqlcipherTarball} node_modules/@signalapp/better-sqlite3/deps/sqlcipher.tar.gz
            pushd node_modules/@signalapp/better-sqlite3
              # node-gyp isn't consistently linked into better-sqlite's `node_modules` (maybe due to version mismatch with sinal-desktop's node-gyp?)
              PATH="$PATH:$(pwd)/../../.bin" yarn --offline build-release
            popd

            pushd node_modules/@signalapp/libsignal-client
              yarn node-gyp-build
            popd
            # there are more dependencies which had install/postinstall scripts, but it seems we can safely ignore them

            # run signal's own `postinstall`:
            yarn build:acknowledgments
            yarn patch-package
            # yarn electron:install-app-deps  # not necessary

            runHook postConfigure
          '';

          # excerpts from package.json:
          # - "build": "run-s --print-label generate build:esbuild:prod build:release"
          #   - "generate": "npm-run-all build-protobuf build:esbuild sass get-expire-time copy-components"
          #     - "build-protobuf": "yarn build-module-protobuf"
          #       - "build-module-protobuf": "pbjs --target static-module --force-long --no-typeurl --no-verify --no-create --wrap commonjs --out ts/protobuf/compiled.js protos/*.proto && pbts --out ts/protobuf/compiled.d.ts ts/protobuf/compiled.js"
          #     - "build:esbuild": "node scripts/esbuild.js"
          #     - "sass": "sass stylesheets/manifest.scss:stylesheets/manifest.css stylesheets/manifest_bridge.scss:stylesheets/manifest_bridge.css"`
          #     - "get-expire-time": "node ts/scripts/get-expire-time.js"
          #     - "copy-components": "node ts/scripts/copy.js"
          #   - "build:esbuild:prod": "node scripts/esbuild.js --prod"
          #   - "build:release": "cross-env SIGNAL_ENV=production yarn build:electron -- --config.directories.output=release"
          #     - "build:electron": "electron-builder --config.extraMetadata.environment=$SIGNAL_ENV"
          #
          # - "build:dev": "run-s --print-label generate build:esbuild:prod"
          #
          # i can't call toplevel `yarn build` because it doesn't properly forward the `--offline` flags where they need to go.
          # instead i call each step individually.

          buildPhase = ''
            runHook preBuild

            # allow building with different node version than what upstream package.json requests
            # (i still use the same major version)
            # echo 'ignore-engines true' > .yarnrc

            # yarn generate:
            yarn build-module-protobuf --offline --frozen-lockfile
            yarn build:esbuild --offline --frozen-lockfile
            # yarn build:dns-fallback --offline --frozen-lockfile  # requires network
            yarn build:icu-types --offline --frozen-lockfile
            yarn build:compact-locales --offline --frozen-lockfile
            yarn sass
            yarn get-expire-time
            yarn copy-components

            yarn build:esbuild:prod --offline --frozen-lockfile

            yarn build:release \
              --linux --${hostNpmArch} \
              -c.electronDist=${electron'}/libexec/electron \
              -c.electronVersion=${electron'.version} \
              --dir

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            # directory structure follows the original `signal-desktop` nix package
            mkdir -p $out/lib
            cp -R release/linux${crossNpmArchExt}-unpacked $out/lib/Signal
            # cp -R release/linux-unpacked/resources $out/lib/Signal/resources
            # cp -R release/linux-unpacked/locales $out/lib/Signal/locales

            mkdir $out/bin

            runHook postInstall
          '';

          preFixup = ''
            # fixup the app.asar to use host nodejs
            ${super.buildPackages.asar}/bin/asar extract $out/lib/Signal/resources/app.asar unpacked
            rm $out/lib/Signal/resources/app.asar
            patchShebangs --host --update unpacked
            ${super.buildPackages.asar}/bin/asar pack unpacked $out/lib/Signal/resources/app.asar

            # XXX: add --ozone-platform-hint=auto to make it so that NIXOS_OZONE_WL isn't *needed*.
            # electron should auto-detect x11 v.s. wayland: launching with `NIXOS_OZONE_WL=1` is an optional way to force it when debugging.
            # xdg-utils: needed for ozone-platform-hint=auto to work
            # else `LaunchProcess: failed to execvp: xdg-settings`
            makeShellWrapper ${electron'}/bin/electron $out/bin/signal-desktop \
              "''${gappsWrapperArgs[@]}" \
              --add-flags $out/lib/Signal/resources/app.asar \
              --suffix PATH : ${super.lib.makeBinPath [ pkgs.xdg-utils ]} \
              --add-flags --ozone-platform-hint=auto \
              --add-flags "\''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-features=WaylandWindowDecorations}" \
              --inherit-argv0
          '';

          passthru = {
            # inherit bettersqlitePatch signal-fts5-extension;
            updateScript = super.gitUpdater {
              rev-prefix = "v";
              ignoredVersions = "beta";
            };
            nodejs = nodejs';
            buildYarn = buildYarn;
            buildNodejs = buildNodejs;
          };

          meta = {
            description = "Private, simple, and secure messenger";
            longDescription = ''
              Signal Desktop is an Electron application that links with your
              "Signal Android" or "Signal iOS" app.
            '';
            homepage = "https://signal.org/";
            changelog = "https://github.com/signalapp/Signal-Desktop/releases/tag/v${version}";
            license = super.lib.licenses.agpl3Only;
          };
        };

      wldash = super.wldash.override (old: {
        rustPlatform = old.rustPlatform // {
          buildRustPackage = args: old.rustPlatform.buildRustPackage (args // {
            src = super.fetchFromGitHub {
              owner = "cyrinux";
              repo = "wldash";
              rev = "9cc29f2507a746ef6359dd081d9f2fe2f43c2a23";
              hash = "sha256-aATJIHETQDX1UXkn5/1jVESgdQFbTFySYuL01NvP54s=";
            };
            cargoSha256 = "sha256-Ot+GnnbFFS6e86uhNDoujlX/oQX9Ckp+M467sXJOD60=";
            cargoPatches = [ ];
          });
        };
      });

      # it was never meant to be packaged with --libnotify by default ☹️
      yubikey-touch-detector = super.yubikey-touch-detector.overrideAttrs (old: {
        postInstall = old.postInstall + ''
          substituteInPlace $out/lib/systemd/user/*.service --replace "--libnotify" ""
        '';
      });

      joypixels = super.joypixels.overrideAttrs (_old: {
        version = "9.0.0";
        src = super.fetchurl {
          name = "joypixels-android.ttf";
          url = "https://maximbaz.com/joypixels-emoji.ttf";
          sha256 = "0ghh5s4ri4lpf43nnpjck9g3y6s4cl9mwkjq78wzfaqj0rbaqqd6";
        };
      });

      maximbaz-scripts = pkgs.stdenv.mkDerivation {
        pname = "maximbaz-scripts";
        version = "1.0.0";
        src = ./bin;
        dontUnpack = true;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        installPhase = ''
          install -Dm755 $src/* -t $out/bin/
          install -Dm755 $src/dmenu $out/bin/dmenu-wl
        '';
        postFixup = ''
          for script in $out/bin/*; do 
            wrapProgram $script \
              --suffix PATH : /run/wrappers/bin/ \
              --suffix PATH : /etc/profiles/per-user/maximbaz/bin/ \
              --suffix PATH : /run/current-system/sw/bin/ \
              ;
          done
        '';
      };
    })
  ];
}
