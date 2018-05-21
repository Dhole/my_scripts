#!/usr/bin/env python3

import sys, os, re, shutil

SUB_PATHS = ['.', 'photography']

def get_author_path(dest_path, author):
    for sub_path in SUB_PATHS:
        path = os.path.join(dest_path, sub_path)
        for author_dir in os.listdir(path):
            author_path = os.path.join(path, author_dir)
            if not os.path.isdir(author_path):
                continue
            if author_dir.startswith(author):
                return author_path
    author_path = os.path.join(dest_path, author)
    print("INFO: Making new directory for author {}".format(author))
    os.mkdir(author_path)
    return author_path

def main(source_path, dest_path):
    for filename in os.listdir(source_path):
        author = re.search('(?<=by_).*(?=-.*\..*)', filename)
        if author:
            author_path = get_author_path(dest_path, author.group(0))
            dest_file = os.path.join(author_path, filename)
            source_file = os.path.join(source_path, filename)
            if os.path.isfile(dest_file):
                print("WARN: File {} already exists at {}".format(filename, dest_file))
                continue
            shutil.move(source_file, dest_file)
        else:
            print("WARN: Couldn't extract author of {}".format(filename))

if __name__ == "__main__":
    if len(sys.argv) != 3:
        if len(sys.argv) == 2 and sys.argv[1] == '--default':
            src =  "/home/black/Downloads/bazzacuda/deviantart/"
            dst =  "/run/media/black/40864c6d-2982-44ee-b391-a0b97777a1ce/data/data1/Imatges/authors"
        else:    
            print("Usage: {} SOURCE DEST".format(sys.argv[0]))
            print("Classify DeviantArt pictures from SOURCE folder into DEST folder.")
            sys.exit(1)
    else:
        src = sys.argv[1]
        dst = sys.argv[2]

    main(src, dst)
