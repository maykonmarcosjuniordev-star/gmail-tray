all:
	rm -rf gmail-tray-*-any.pkg.tar.zst
	makepkg --printsrcinfo > .SRCINFO
	makepkg -fsirc
	sudo pacman -U --noconfirm gmail-tray-*-any.pkg.tar.zst

commit:
	makepkg -fsirc
	makepkg --printsrcinfo > .SRCINFO
	git add .
	git commit -m "new version"
	git push

