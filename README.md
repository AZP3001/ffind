# ffind
A recursive file aggregation utility. Parses directories via POSIX-extended regex to execute flat or tree-preserving bulk copies with automated namespace collision mitigation.
## Features
 * **Format Targeting**: Precise extension parsing (-f) or predefined categorical arrays (-p).
 * **Namespace Collision Handling**: Appends incrementing integers to duplicate basenames in flat-copy mode.
 * **Topology Preservation**: Replicates upstream $indir directory structures dynamically (-d).
 * **POSIX-Compliant**: Interpreted via bash, utilizing native findutils and coreutils dependencies.
## Installation (Arch Linux)
Requires a PKGBUILD manifest in the repository root for fakeroot compilation.
```bash
git clone [https://github.com/](https://github.com/)<user>/<repo>.git && cd <repo> && makepkg -si

```
## Synopsis
```bash
ffind -i <input dir> -o <output dir> [-f <filetype1,filetype2> | -p <preset>] [-d]

```
## Flags
| Flag | Parameter | Description |
|---|---|---|
| -i | <indir> | Source directory absolute/relative path. |
| -o | <outdir> | Target destination directory path. |
| -f | <ext1,ext2> | Comma-separated array of file extensions. |
| -p | <preset> | Categorical extension preset mapping. |
| -d | null | Persist source topology (tree-preserve mode). |
| -h | null | Invoke stdout help block. |
## Presets (-p)
 * **zip**: zip,7z,gz,tgz,rar,tar,bz2,xz
 * **image**: png,jpeg,jpg,webp,ico,icon,gif,bmp,svg,tiff
 * **video**: mp4,mkv,avi,mov,wmv,flv,webm,m4v
 * **audio**: mp3,flac,wav,ogg,m4a,aac,wma,alac
 * **txt**: txt,yaml,yml,json,md,csv,xml,ini,conf,sh
## Examples
**Flat copy specific extensions (collision mitigation active):**
```bash
ffind -i ~/Downloads -o ~/Documents/configs -f yaml,json,conf

```
**Copy predefined image formats while preserving directory structure:**
```bash
ffind -i /mnt/data/archives -o ~/Pictures/dump -p image -d

```
