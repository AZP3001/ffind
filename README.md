# ffind

A recursive file aggregation utility. Parses directories via POSIX-extended regex to execute flat or tree-preserving bulk copies with automated namespace collision mitigation.

## Features
* **Format Targeting**: Precise extension parsing (`-f`) or predefined categorical arrays (`-p`).
* **Namespace Collision Handling**: Appends incrementing integers to duplicate basenames in flat-copy mode.
* **Topology Preservation**: Replicates upstream `$indir` directory structures dynamically (`-d`).
* **POSIX-Compliant**: Interpreted via `bash`, utilizing native `findutils` and `coreutils` dependencies.

## Installation (Arch Linux)

Requires a `PKGBUILD` manifest in the repository root for `fakeroot` compilation.

```bash
git clone [https://github.com/](https://github.com/)<user>/<repo>.git && cd <repo> && makepkg -si
