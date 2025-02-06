#!/bin/bash

# Exit on any error
set -e

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install it first:"
    echo "macOS: brew install pandoc"
    echo "Ubuntu/Debian: sudo apt-get install pandoc"
    exit 1
fi

# Check if xelatex is installed
if ! command -v xelatex &> /dev/null; then
    echo "Error: xelatex not found. Please install a TeX distribution:"
    echo "macOS: brew install --cask mactex"
    echo "   or for a smaller install: brew install --cask basictex"
    echo "Ubuntu/Debian: sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-fonts-extra"
    exit 1
fi

# Input and output configuration
INPUT="resume.md"
OUTPUT_DIR="output"

# Check if input file exists
if [ ! -f "$INPUT" ]; then
    echo "Error: $INPUT not found"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Convert to PDF
echo "Converting to PDF..."
pandoc "$INPUT" \
    -o "$OUTPUT_DIR/resume.pdf" \
    --pdf-engine=xelatex \
    --variable mainfont="Helvetica" \
    --variable monofont="Menlo" \
    -V geometry:margin=0.3in \
    -V colorlinks=true \
    -V linkcolor=blue \
    -V urlcolor=blue \
    -V fontsize=8pt \
    -V documentclass=article \
    -V papersize=letter \
    -V linestretch=0.7 \
    --variable=header-includes:"\usepackage{setspace}" \
    --variable=header-includes:"\setlength{\parskip}{3pt}" \
    --variable=header-includes:"\setlength{\parindent}{0pt}" \
    --variable=header-includes:"\setlength{\emergencystretch}{1em}" \
    --variable=header-includes:"\usepackage[none]{hyphenat}" \
    --variable=header-includes:"\usepackage{enumitem}" \
    --variable=header-includes:"\setlist[itemize]{label=\textbullet,itemsep=4pt,topsep=0pt,parsep=0pt,partopsep=0pt,leftmargin=3em}" \
    --variable=header-includes:"\usepackage{titlesec}" \
    --variable=header-includes:"\titlespacing{\section}{0pt}{6pt}{2pt}" \
    --variable=header-includes:"\titlespacing{\subsection}{0pt}{4pt}{1pt}" \
    --variable=header-includes:"\titleformat{\section}{\normalfont\bfseries\Large\centering}{\thesection}{0pt}{}" \
    --variable=header-includes:"\titleformat{\subsection}{\normalfont\bfseries\large}{\thesubsection}{0pt}{}" \
    --variable=header-includes:"\renewcommand{\baselinestretch}{0.7}"
echo "PDF conversion complete!"

# Convert to DOCX
echo "Converting to DOCX..."
pandoc "$INPUT" -o "$OUTPUT_DIR/resume.docx"
echo "DOCX conversion complete!" 