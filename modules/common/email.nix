{ config, pkgs, lib, ... }: {
  config = lib.mkIf config.personal.enable {
    home-manager.users.${config.user} = {
      programs = {
        aerc = {
          enable = true;
          extraConfig = ''
            [compose]
            edit-headers = true
            file-picker-cmd = fzf --multi --query=%s
            reply-to-self = false

            [filters]
            .headers = ${pkgs.aerc}/libexec/aerc/filters/colorize
            text/calendar = ${pkgs.gawk}/bin/awk -f ${pkgs.aerc}/libexec/aerc/filters/calendar
            text/html = ${pkgs.aerc}/libexec/aerc/filters/html -o display_link_number=true | ${pkgs.aerc}/libexec/aerc/filters/colorize
            text/plain = ${pkgs.aerc}/libexec/aerc/filters/colorize
            text/* = ${pkgs.bat}/bin/bat -fP --file-name="$AERC_FILENAME "
            message/delivery-status = ${pkgs.aerc}/libexec/aerc/filters/colorize
            message/rfc822 = ${pkgs.aerc}/libexec/aerc/filters/colorize
            application/pdf = ${pkgs.zathura}/bin/zathura -
            application/x-sh = ${pkgs.bat}/bin/bat -fP -l sh
            audio/* = ${pkgs.mpv}/bin/mpv -

            [general]
            default-menu-cmd = ${pkgs.fzf}/bin/fzf
            enable-osc8 = true
            pgp-provider = gpg
            unsafe-accounts-conf = true

            [viewer]
            header-layout = From|To,Cc|Bcc,Date,Subject,DKIM+|SPF+|DMARC+

            [ui]
            tab-title-account = {{.Account}} {{if .Unread}}({{.Unread}}){{end}}
            fuzzy-complete = true
            mouse-enabled = true
            msglist-scroll-offset = 5
            show-thread-context = true
            thread-prefix-dummy = ┬
            thread-prefix-first-child = ┬
            thread-prefix-folded = +
            thread-prefix-has-siblings = ├
            thread-prefix-indent = 
            thread-prefix-last-sibling = ╰
            thread-prefix-limb = ─
            thread-prefix-lone =  
            thread-prefix-orphan = ┌
            thread-prefix-stem = │
            thread-prefix-tip = 
            thread-prefix-unfolded = 
            threading-enabled = true
            spinner="◜,◠,◝,◞,◡,◟"
          '';

          extraBinds = ''
            <C-k> = :prev-tab<Enter>
            <C-j> = :next-tab<Enter>
            ? = :help keys<Enter>
            <C-c> = :prompt 'Quit?' quit<Enter>
            <C-q> = :prompt 'Quit?' quit<Enter>

            [messages]
            q = :prompt 'Quit?' quit<Enter>
            j = :next<Enter>
            k = :prev<Enter>
            <C-d> = :next 50%<Enter>
            <C-u> = :prev 50%<Enter>
            <PgDn> = :next 100%<Enter>
            <PgUp> = :prev 100%<Enter>
            g = :select 0<Enter>
            G = :select -1<Enter>
            J = :next-folder<Enter>
            K = :prev-folder<Enter>

            <Space> = :mark -t<Enter>:next<Enter>
            <Tab> = :exec checkmail<Enter>
            <Enter> = :view<Enter>
            d = :choose -o y 'Really delete this message' delete-message<Enter>
            a = :read<Enter>:archive flat<Enter>
            A = :unmark -a<Enter>:mark -T<Enter>:read<Enter>:mark -T<Enter>:archive flat<Enter>
            s = :read<Enter>:move Junk<Enter>

            m = :compose<Enter>
            r = :reply -aq<Enter>
            $ = :term<space>
            ! = :term<space>
            | = :pipe<space>

            / = :search<space>
            \ = :change-tab notmuch<Enter>:cf<Space>
            + = :query -n "{{.SubjectBase}} ({{.MessageId}})" -a notmuch thread:\{id:{{.MessageId}}\}<Enter>
            n = :next-result<Enter>
            N = :prev-result<Enter>
            <Esc> = :clear<Enter>

            v = :split<Enter>
            V = :vsplit<Enter>

            [messages:folder=Drafts]
            <Enter> = :recall<Enter>

            [view]
            / = :toggle-key-passthrough<Enter>/
            q = :close<Enter>
            o = :open<Enter>
            S = :save<space>
            | = :pipe<space>
            a = :archive flat<Enter>
            s = :move Junk<Enter>

            <C-l> = :open-link<space>

            f = :forward<Enter>
            r = :reply -aq<Enter>

            H = :toggle-headers<Enter>
            <C-p> = :prev-part<Enter>
            <C-n> = :next-part<Enter>
            J = :next<Enter>
            K = :prev<Enter>

            [view::passthrough]
            $noinherit = true
            $ex = <C-x>
            <Esc> = :toggle-key-passthrough<Enter>

            [compose]
            $noinherit = true
            $ex = <C-x>

            [compose::editor]
            $noinherit = true
            $ex = <C-x>

            [compose::review]
            y = :send<Enter> # Send
            n = :abort<Enter> # Abort (discard message, no confirmation)
            v = :preview<Enter> # Preview message
            p = :postpone<Enter> # Postpone
            q = :choose -o d discard abort -o p postpone postpone<Enter> # Abort or postpone
            e = :edit<Enter> # Edit
            a = :menu -c 'fd . --type=f | fzf -m' attach<Enter> # Add attachment
            d = :detach<space> # Remove attachment
            s = :sign<Enter> # PGP sign

            [terminal]
            $noinherit = true
            $ex = <C-x>
            <C-p> = :prev-tab<Enter>
            <C-n> = :next-tab<Enter>
          '';
        };

        notmuch = {
          enable = true;
          new = {
            ignore = [
              ".uidvalidity"
              ".mbsyncstate"
              ".mbsyncstate.lock"
              ".mbsyncstate.journal"
              ".mbsyncstate.new"
            ];
            tags = [ "unread" "inbox" "new" ];
          };
        };

        msmtp.enable = true;
        mbsync.enable = true;
      };

      accounts.email = {
        maildirBasePath = ".mail";
        accounts.notmuch = {
          realName = "notmuch";
          address = "notmuch@localhost";
          aerc = {
            enable = true;
            extraAccounts.source = "notmuch://~/.mail";
            extraBinds.messages."r" = '':reply -aqA {{index (.Filename | split ("/")) 4}}<Enter>'';
            extraBinds.view."r" = '':reply -aqA {{index (.Filename | split ("/")) 4}}<Enter>'';
          };
        };
      };

      services = {
        imapnotify.enable = true;
        mbsync = {
          enable = true;
          postExec = "${lib.getExe' pkgs.maximbaz-scripts "indexmail"}";
        };
      };

      systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];

      home.packages = with pkgs; [
        aerc
        w3m
        dante
      ];
    };
  };
}

