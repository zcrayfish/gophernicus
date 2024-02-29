#!/bin/ash
readonly TEMPDIR=$(mktemp -d /tmp/gophernicusXXXXXX) || exit

if uname | grep -q 'Darwin' ; then
    # I do not have hardware to make this work on and am uninterested in
    # making another testsuite for travis Macs at this time
    exit 0
fi

mkdir -p $TEMPDIR
cp .travis/test.gophermap $TEMPDIR/gophermap
chmod 755 $TEMPDIR
chmod 644 $TEMPDIR/gophermap

#test 1, test a basic gophermap,
echo -e "\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test1.output
if ! cmp .travis/test1.answer $TEMPDIR/test1.output ; then
    echo test1 round1 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test1.answer $TEMPDIR/test1.output
    exit 1
else
   echo test1 round1 passed
fi
echo -e "\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test1.output
if ! cmp .travis/test1.answer $TEMPDIR/test1.output ; then
    echo test1 round2 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test1.answer $TEMPDIR/test1.output
    exit 1
else
   echo test1 round2 passed
fi
#test 1, test a basic gophermap
echo -e "/\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test1.output
if ! cmp .travis/test1.answer $TEMPDIR/test1.output ; then
    echo test1 round3 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test1.answer $TEMPDIR/test1.output
    exit 1
else
   echo test1 round3 passed
fi
echo -e "/\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test1.output
if ! cmp .travis/test1.answer $TEMPDIR/test1.output ; then
    echo test1 round4 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test1.answer $TEMPDIR/test1.output
    exit 1
else
   echo test1 round4 passed
fi
#test 1, test a basic gophermap
echo -e "GET /\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test1.output
if ! cmp .travis/test1.answer $TEMPDIR/test1.output ; then
    echo test1 round5 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test1.answer $TEMPDIR/test1.output
    exit 1
else
   echo test1 round5 passed
fi
#test 1, test a basic gophermap
echo -e "GET /\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test1.output
if ! cmp .travis/test1.answer $TEMPDIR/test1.output ; then
    echo test1 round6 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test1.answer $TEMPDIR/test1.output
    exit 1
else
   echo test1 round6 passed
fi

#test 2 test a non-existant file
echo -e "FAKEFILE\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test2.output
if ! cmp .travis/test2.answer $TEMPDIR/test2.output ; then
    echo test2 round1 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test2.answer $TEMPDIR/test2.output
    exit 1
else
   echo test2 round1 passed
fi

#test 2 test a non-existant file
echo -e "FAKEFILE\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test2.output
if ! cmp .travis/test2.answer $TEMPDIR/test2.output ; then
    echo test2 round2 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test2.answer $TEMPDIR/test2.output
    exit 1
else
   echo test2 round2 passed
fi

#test 2 test a non-existant file
echo -e "/FAKEFILE\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test2.output
if ! cmp .travis/test2.answer $TEMPDIR/test2.output ; then
    echo test2 round3 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test2.answer $TEMPDIR/test2.output
    exit 1
else
   echo test2 round3 passed
fi

#test 2 test a non-existant file
echo -e "/FAKEFILE\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test2.output
if ! cmp .travis/test2.answer $TEMPDIR/test2.output ; then
    echo test2 round4 FAILED, test info saved at $TEMPDIR, diff between expected output and actual output:
    diff .travis/test2.answer $TEMPDIR/test2.output
    exit 1
else
   echo test2 round4 passed
fi

#test 3 test a non-existant GIF
echo -e "/FAKE.GIF\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test3.output
if ! cmp .travis/test3.answer $TEMPDIR/test3.output ; then
    'echo test3 round1 FAILED, test info saved at $TEMPDIR, diff not displayed (binary files expected)'
    exit 1
else
   echo test3 round1 passed
fi

#test 3 test a non-existant GIF
echo -e "/FAKE.GIF\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test3.output
if ! cmp .travis/test3.answer $TEMPDIR/test3.output ; then
    'echo test3 round2 FAILED, test info saved at $TEMPDIR, diff not displayed (binary files expected)'
    exit 1
else
   echo test3 round2 passed
fi

#test 4 test file extensions
mkdir -p $TEMPDIR/extensions
for ext in txt pl py sh tcl c cpp h log conf php php3 hqx Z gz tgz tar zip bz2 rar sea uue iso so o rtf ttf bin ics ical gif html htm xhtml css rdf rss xml svg jpg jpeg jfif png bmp ico xbm xpm pcx webp mbox eml mht mhtml doc ppt xls xlsx docx pptx mp3 mp2 wav mid midi wma flac ogg aiff aac m4a opus avi mp4 mpg mov qt asf mpv m4v webm ogv 3gp 3g2 wmv pic pict tif tiff pdf ps
do
  touch $TEMPDIR/extensions/empty.$ext
done
echo -e "extensions\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test4.output
if ! cmp .travis/test4.answer $TEMPDIR/test4.output ; then
    echo test4 round1 FAILED, diff between expected and actual output
    diff .travis/test4.answer $TEMPDIR/test4.output
    exit 1
else
   echo test4 round1 passed
fi
echo -e "extensions\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test4.output
if ! cmp .travis/test4.answer $TEMPDIR/test4.output ; then
    echo test4 round2 FAILED, diff between expected and actual output
    diff .travis/test4.answer $TEMPDIR/test4.output
    exit 1
else
   echo test4 round2 passed
fi
echo -e "/extensions\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test4.output
if ! cmp .travis/test4.answer $TEMPDIR/test4.output ; then
    echo test4 round3 FAILED, diff between expected and actual output
    diff .travis/test4.answer $TEMPDIR/test4.output
    exit 1
else
   echo test4 round3 passed
fi
echo -e "GET /extensions\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test4.output
if ! cmp .travis/test4.answer $TEMPDIR/test4.output ; then
    echo test4 round5 FAILED, diff between expected and actual output
    diff .travis/test4.answer $TEMPDIR/test4.output
    exit 1
else
   echo test4 round5 passed
fi

#test5 Tests gophernicus' detection of files without extensions (i.e. using magic numbers)
mkdir -p $TEMPDIR/magic
echo 'GIF87a' > $TEMPDIR/magic/gif87a
echo 'GIF89a' > $TEMPDIR/magic/gif89a
echo -e '\377\330\377\340' > $TEMPDIR/magic/jfif
echo -e '\377\330\377\341' > $TEMPDIR/magic/exif
echo -e '\377\330\377\342' > $TEMPDIR/magic/ciff
echo -e '\377\330\377\348' > $TEMPDIR/magic/spiff
echo -e '\211PNG' > $TEMPDIR/magic/png
echo -e '\111\111\052\000' > $TEMPDIR/magic/tiffle
echo -e '\115\155\000\052' > $TEMPDIR/magic/tiffbe
echo -e '\nContent-Type: ' > $TEMPDIR/magic/mime
echo '<html>' > $TEMPDIR/magic/htmllc
echo '<HTML>' > $TEMPDIR/magic/htmluc
echo '<?xml ' > $TEMPDIR/magic/xml
echo -e '\037\235\220' > $TEMPDIR/magic/gz1
echo -e '\037\213\010' > $TEMPDIR/magic/gz2
echo 'fLaC' > $TEMPDIR/magic/flac
echo 'MThd' > $TEMPDIR/magic/midi
echo 'ID3' > $TEMPDIR/magic/mp3id3
echo -e '\032\105\337\243' > $TEMPDIR/magic/matroska
echo -e '\000\000\001\272' > $TEMPDIR/magic/mpeg
echo -e '\000\000\001\263' > $TEMPDIR/magic/anothermpeg
echo 'begin 644 fake.file' > $TEMPDIR/magic/uuencode
echo -e 'begin-base64 644 fake.file\nCg==\n====' > $TEMPDIR/magic/uuencodeb64
echo 'This is a plain text file I guess' > $TEMPDIR/magic/unknown
echo -e "magic\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test5.output
if ! cmp .travis/test5.answer $TEMPDIR/test5.output ; then
    echo test5 round1 FAILED, diff between expected and actual output
    diff .travis/test5.answer $TEMPDIR/test5.output
    exit 1
else
   echo test5 round1 passed
fi
echo -e "magic\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test5.output
if ! cmp .travis/test5.answer $TEMPDIR/test5.output ; then
    echo test5 round2 FAILED, diff between expected and actual output
    diff .travis/test5.answer $TEMPDIR/test5.output
    exit 1
else
   echo test5 round2 passed
fi
echo -e "/magic\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test5.output
if ! cmp .travis/test5.answer $TEMPDIR/test5.output ; then
    echo test5 round3 FAILED, diff between expected and actual output
    diff .travis/test5.answer $TEMPDIR/test5.output
    exit 1
else
   echo test5 round3 passed
fi
echo -e "/magic\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test5.output
if ! cmp .travis/test5.answer $TEMPDIR/test5.output ; then
    echo test5 round4 FAILED, diff between expected and actual output
    diff .travis/test5.answer $TEMPDIR/test5.output
    exit 1
else
   echo test5 round4 passed
fi
echo -e "GET /magic\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test5.output
if ! cmp .travis/test5.answer $TEMPDIR/test5.output ; then
    echo test5 round5 FAILED, diff between expected and actual output
    diff .travis/test5.answer $TEMPDIR/test5.output
    exit 1
else
   echo test5 round5 passed
fi
echo -e "GET /magic\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -nr -r $TEMPDIR > $TEMPDIR/test5.output
if ! cmp .travis/test5.answer $TEMPDIR/test5.output ; then
    echo test5 round6 FAILED, diff between expected and actual output
    diff .travis/test5.answer $TEMPDIR/test5.output
    exit 1
else
   echo test5 round6 passed
fi

#test 6, ensure gophericus dies quickly if run as root
if [ "$(id -u)" -ne 0 ]; then
  echo 'test6 skipped (check if gophernicus rightly refuses to run as root)'
else
  echo -e "/\r\n" | src/gophernicus -h test.invalid -nf -nu -nv -nx -nf -nd -r $TEMPDIR > $TEMPDIR/test6.output
if ! cmp .travis/test6.answer $TEMPDIR/test6.output ; then
    echo test6 FAILED, diff between expected and actual output
    echo "DANGER DANGER DANGER, this gophernicus is UNSAFE to use in production!"
    diff .travis/test6.answer $TEMPDIR/test6.output
    exit 1
  else
    echo test6 passed
  fi
fi

echo "All important tests passed, deleting the temporary directory at $TEMPDIR"
rm -rf $TEMPDIR
if ! src/gophernicus -v | grep -q 'Gophernicus/3.1.1 "zcrayfish fork"' ; then
    echo 'Possible version mismatch (if no errors ABOVE, this is not fatal)'
    exit 1
fi
