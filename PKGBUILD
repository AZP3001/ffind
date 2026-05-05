pkgname=ffind-git
pkgver=r1
pkgrel=1
pkgdesc="Recursively aggregate and copy files by extension or preset"
arch=('any')
url="https://github.com/AZP3001/ffind.git"
license=('GPL')
depends=('bash' 'coreutils' 'findutils')
makedepends=('git')
provides=('ffind')
conflicts=('ffind')
source=("${pkgname%-git}::git+https://github.com/AZP3001/ffind.git")
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/${pkgname%-git}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
  cd "$srcdir/${pkgname%-git}"
  install -Dm755 ffind.sh "$pkgdir/usr/bin/ffind"
  install -Dm644 ffind.1 "$pkgdir/usr/share/man/man1/ffind.1"
}
