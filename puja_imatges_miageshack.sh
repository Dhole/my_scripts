for files in *.gif *.jpg *.png; do curl -H Expect: -F fileupload="@$files" -F xml=yes -# "http://www.imageshack.us/index.php" | grep image_link | sed -e 's/<image_link>/[IMG]/g' -e 's/<\/image_link>/[\/IMG]/g'; done; 

