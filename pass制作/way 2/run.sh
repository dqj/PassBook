cd ./example
rm manifest.json
rm signature
rm example.pkpass
set MANIFEST = ../manifest.json
 echo '{' > $MANIFEST
 foreach i (*)
   set sha1 = `openssl sha1 $i | cut -d' ' -f2`
   echo \"$i\" : \"$sha1\", >> $MANIFEST
 end
echo '}' >> $MANIFEST
 cp $MANIFEST .
openssl smime -binary -sign -signer ../passcert.pem -inkey ../passkey.pem -passin pass:1234 -in manifest.json -out signature -outform DER
zip -r example.pkpass ./* -x '*.pem'
