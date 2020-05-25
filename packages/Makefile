.PHONY: all
all: build install refresh publish clean

.PHONY: build
build:
	PKGEXT='.pkg.tar.zst' makepkg -sf

.PHONY: install
install:
	SNAP_PAC_SKIP=true sudo -E pacman --noconfirm -U *.pkg.tar.zst

.PHONY: refresh
refresh:
	backup-packages
	if [ -s unknown.list ]; then \
		xargs -a unknown.list sudo -E pacman -D --asdeps; \
	fi
	backup-packages

.PHONY: publish
publish:
	gpg --detach-sign --yes *.pkg.tar.zst
	repo-add -s /var/cache/pacman/maximbaz/maximbaz.db.tar *.pkg.tar.zst
	cp *.pkg.tar* /var/cache/pacman/maximbaz/

.PHONY: clean
clean:
	rm -rf pkg src *.pkg.tar* *.log
