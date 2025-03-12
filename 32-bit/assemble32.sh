#!/bin/bash

# check if the correct argument was passed
if [ -z "$1" ]; then
	echo "Usage: $0 <source.asm>"
	exit 1
fi

filename="${1%.*}" # Get the filename w/o extension

# assemble
echo "Assembling..."
nasm -f elf32 "$1" -o "$filename.o"

# link
echo "Linking..."
ld -m elf_i386 -s -o "$filename" "$filename.o"

echo "Assembly complete: ./$filename"
