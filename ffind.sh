#!/usr/bin/env bash

show_help() {
    echo "Usage: ffind -i <indir> -o <outdir> [-f <ext1,ext2> | -p <preset>] [-d]"
    echo "       ffind <indir> <outdir> <ext1,ext2> [-d]"
    echo "Flags:"
    echo "  -i    Input directory"
    echo "  -o    Output directory"
    echo "  -f    CSV file formats (e.g., zip,txt)"
    echo "  -p    Format presets: zip, image, video, audio, txt"
    echo "  -d    Preserve directory tree"
    echo "  -h    Show this help"
    exit 0
}

cat > "${TMPDIR:-/tmp}/_ffind_helper.sh" << 'HELPEREOF'
outdir="$1"
flat="$2"
indir="$3"
file="$4"
base=$(basename "$file")
if [ "$flat" = "0" ]; then
    name="${base%.*}"
    ext="${base##*.}"
    if [ "$name" = "$base" ]; then ext=""; else ext=".${ext}"; fi
    destpath="${outdir}/${name}${ext}"
    counter=2
    while [ -e "$destpath" ]; do
        destpath="${outdir}/${name}${counter}${ext}"
        counter=$((counter + 1))
    done
else
    relpath="${file#${indir}/}"
    destpath="${outdir}/${relpath}"
    mkdir -p "$(dirname "$destpath")"
fi
rawsize=$(stat -c%s "$file")
size_kb=$(( (rawsize + 1023) / 1024 ))
echo "Copying: $(basename "$destpath") - ${size_kb} KB"
cp "$file" "$destpath"
HELPEREOF

_ffind_run() {
    local indir="$1" outdir="$2" types="$3" flat="$4" types_regex
    types_regex=$(echo "$types" | sed 's/,/|/g')
    rm -rf "$outdir"
    mkdir -p "$outdir"
    find "$indir" -type f -regextype posix-extended -iregex ".*\.(${types_regex})$" -exec sh "${TMPDIR:-/tmp}/_ffind_helper.sh" "$outdir" "$flat" "$indir" {} \;
}

main() {
    local indir outdir types flat=0
    
    if [ $# -eq 0 ]; then show_help; fi
    
    case "$1" in
        -help|--help|-h) show_help ;;
        -i|-o|-f|-p|-d)
            while [ $# -gt 0 ]; do
                case "$1" in
                    -help|--help|-h) show_help ;;
                    -i) indir="$2"; shift 2 ;;
                    -o) outdir="$2"; shift 2 ;;
                    -f) types="$2"; shift 2 ;;
                    -p) 
                        case "${2,,}" in
                            zip) types="zip,7z,gz,tgz,rar,tar,bz2,xz" ;;
                            image) types="png,jpeg,jpg,webp,ico,icon,gif,bmp,svg,tiff" ;;
                            video) types="mp4,mkv,avi,mov,wmv,flv,webm,m4v" ;;
                            audio) types="mp3,flac,wav,ogg,m4a,aac,wma,alac" ;;
                            txt) types="txt,yaml,yml,json,md,csv,xml,ini,conf,sh" ;;
                            *) echo "Invalid preset: $2"; exit 1 ;;
                        esac
                        shift 2 
                    ;;
                    -d) flat=1; shift ;;
                    *) shift ;;
                esac
            done
        ;;
        *)
            indir="$1"; outdir="$2"; types="$3"
            if [ "$4" = "-d" ]; then flat=1; fi
        ;;
    esac
    if [ -z "$indir" ] || [ -z "$outdir" ] || [ -z "$types" ]; then
        echo "Missing arguments."
        exit 1
    fi
    _ffind_run "$indir" "$outdir" "$types" "$flat"
}

main "$@"
