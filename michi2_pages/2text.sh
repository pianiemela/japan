#!/bin/bash
shopt -s nullglob

for file in *.pdf; do
    base="${file%.pdf}"
    
    # Extract pages as PNGs
    pdftoppm -png -r 300 "$file" "$base"

    # Process generated PNGs
    for img in "${base}"-*.png; do
        # Pass output basename without extension (Tesseract adds .txt automatically)
        out_base="${img%.png}"
        tesseract "$img" "$out_base" -l jpn+fin --oem 1 --psm 4
        
        # Optional: remove temporary PNG to save disk space
        rm "$img"
    done
done
