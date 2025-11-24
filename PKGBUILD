# Maintainer: Maykon Marcos Junior <maykon.marcos.junior.dev@gmail.com>
pkgname=gmail-tray-git
pkgbase=gmail-tray-git
pkgver=1 # the software’s upstream version (e.g. 1.0, 1.1)
pkgrel=1   # the package release number, change the packaging but not the upstream version
pkgdesc="Minimal Gmail tray notifier with unread counter"
# noarch because it is a Python script and desktop files are architecture independent
arch=('any')
url="https://github.com/maykonmarcosjuniordev-star/gmail-tray"
license=('MIT')
depends=('fetchmail'
          'libnotify'
          'gtk3'
          'python'
          'python-gobject'
          'json-glib'
          'libappindicator-gtk3'
          'libayatana-appindicator'
          'libayatana-appindicator-glib'
)
source=(
  'gmail-tray.py'
  'gmail-tray.desktop'
  'gmail-tray.service'
  'gmail-tray-configs.json'
  'https://upload.wikimedia.org/wikipedia/commons/archive/7/7e/20201210105307%21Gmail_icon_%282020%29.svg'  # gmail.svg
)
# conflicts with gmail-tray and gmail-tray-appimage
conflicts=('gmail-tray' 'gmail-tray-appimage')
sha256sums=('a709f594eaa8ac8220665e616d39c15f4b07c7e721b1b676185c82fa74011408'  # gmail-tray.py
            '0688bfaf05bf4f7bbe8a93f9f885e29a29d700b99e37ce942be9013535c720bc'  # gmail-tray.desktop
            'd14eb5fe03ac56e9afb4e469bc44bb14d61433664bb46d0846bffc5e876d3995'  # gmail-tray.service
            'feeebab234d6a54683d41ecbdbede28117d9bf53d9b7b931040a54933feae08b'  # gmail-tray-configs.json
            '7b6c2b6e3b67271a2a27e11986265745de3ffe8e84f692be79f6f554ac405275'  # gmail.svg
           )
install=
package() {
  install -Dm755 "$srcdir/gmail-tray.py" "$pkgdir/usr/bin/gmail-tray"
  install -Dm644 "$srcdir/gmail-tray-configs.json" "$pkgdir/usr/share/gmail-tray/gmail-tray-configs.json"
  install -Dm644 "$srcdir/gmail-tray.desktop" "$pkgdir/usr/share/applications/gmail-tray.desktop"
  install -Dm644 "$srcdir/gmail-tray.service" "$pkgdir/usr/lib/systemd/user/gmail-tray.service"
  install -Dm644 "$srcdir/20201210105307%21Gmail_icon_%282020%29.svg" "$pkgdir/usr/share/icons/hicolor/48x48/apps/gmail-tray.png"
  install -Dm644 "$srcdir/20201210105307%21Gmail_icon_%282020%29.svg" "$pkgdir/usr/share/pixmaps/gmail-tray.svg"
}
