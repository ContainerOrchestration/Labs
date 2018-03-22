
for i in *.svg; do
    convert $i ${i}.png
    ls -altr $i ${i}.png
done

