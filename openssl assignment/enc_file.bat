@echo off

set "receiver=%~1"
set "filename=%~2"
set "sender=%~3"

if "%receiver%"=="" (
  echo Please provide the receiver's name.
  exit /b
)

if "%filename%"=="" (
  echo Please provide the filename.
  exit /b
)

if "%sender%"=="" (
  echo Please provide the sender's name.
  exit /b
)

REM Step 1: Extract Receiver's Public Key
openssl x509 -in "C:\Users\user\Desktop\Network2openssl\rec\%receiver%Certificate.pem" -pubkey -out "%receiver%PublicKey.pem"

REM Step 2: Generate Shared Key
openssl rand -out Task2sharedkey.bin 64

REM Step 3: Encrypt Shared Key with Receiver's Public Key (using pkeyutl)
openssl pkeyutl -encrypt -pubin -inkey "%receiver%PublicKey.pem" -in Task2sharedkey.bin -out Task2sharedkey.bin.enc

REM Step 4: Encrypt the File with Shared Key (enhanced key derivation)
openssl enc -aes-192-cbc -pbkdf2 -in "%filename%" -out "%filename%.enc" -pass file:Task2sharedkey.bin

REM Step 5: Compute Hash for the File
openssl dgst -sha512 -binary "%filename%" > Task2.sha512

REM Step 6: Sign the Hash with Sender's Private Key
openssl pkeyutl -sign -in Task2.sha512 -out Task2sign.sha512 -inkey "%sender%PrivateKey.pem"

REM Step 7: Verify the Signed Hash with Sender's Public Key
openssl pkeyutl -verify -in Task2.sha512 -sigfile Task2sign.sha512 -pubin -inkey "%sender%PublicKey.pem"

REM Step 8: Output Verification Result
if errorlevel 0 (
echo Signature Verified Successfully
) else (
echo Signature Verification Failed
)

REM Step 9: Send the encrypted file, encrypted shared key, and signed hash to your partner
copy hw3f23.pdf C:\Users\user\Desktop\Network2openssl\rec
copy hw3f23.pdf.enc C:\Users\user\Desktop\Network2openssl\rec
copy Task2sharedkey.bin.enc C:\Users\user\Desktop\Network2openssl\rec
copy Task2sign.sha512 C:\Users\user\Desktop\Network2openssl\rec
