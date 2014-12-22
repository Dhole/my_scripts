#! /bin/sh

# Finds all the duplicate files in the folder recursively and creates a
# rem-duplicates.sh script to delete them. (the file rem-duplicates.sh must
# be executed manually afterwards.

OUTF=rem-duplicates.sh;
echo "#! /bin/sh" > $OUTF;
find "$@" -type f -exec md5sum {} \; |
    sort --key=1,32 | uniq -w 32 -d --all-repeated=separate |
    sed -r 's/^[0-9a-f]*( )*//;s/([^a-zA-Z0-9./_-])/\\\1/g;s/(.+)/#rm \1/;s/\n\n/>>/g' |
    sed ':a;N;$!ba;s/\n\n/\n>><</g'  | tr -d '\015' | sed ':a;N;$!ba;s/"\r"/*/g' | sed 's\#\\g' >> $OUTF  | #sed '<>>>' |
chmod a+x $OUTF; ls -l $OUTF

