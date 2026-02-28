#!/run/current-system/sw/bin/bash

set -e

WALLPAPER_DIR="$HOME/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-selector"
THUMBNAIL_WIDTH="250"
THUMBNAIL_HEIGHT="141"
mkdir -p "$CACHE_DIR"

function make_thumbnail() {
    input=$1
    output=$2

    magick "$input" -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" -gravity center -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" "$output"

}

function make_menu() {
    for img in $WALLPAPER_DIR/*; do
        
        thumbnail="$CACHE_DIR/$(basename $img)"

        if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
            make_thumbnail "$img" "$thumbnail"
        fi

        echo -en "img:$thumbnail\x00info:$(basename "$img")\x1f$img\n"

    done
}

selected=$(make_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image_size=${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf $HOME/.config/wofi/wallpaper \
    --style $HOME/.config/wofi/style.css
)

if [[ -n "$selected" ]]; then

    thumbnail_path="${selected#img:}"
    original_path="$WALLPAPER_DIR/$(basename $thumbnail_path)"

    if [[ -n "$original_path" ]]; then
        echo $original_path
        change_wallpapers.sh "$original_path"
    fi
fi
