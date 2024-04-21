@echo off

set NAME=%1

openssl req -x509 -newkey rsa:4096 -keyout %name%PrivateKey.pem -out %name%Certificate.pem -days 365

openssl x509 -in %name%Certificate.pem -pubkey -out %name%PublicKey.pem

echo Displaying generated files...
notepad "%name%Certificate.pem"
notepad "%name%PrivateKey.pem"
notepad "%name%PublicKey.pem"

echo Certificate and key files generated successfully!
