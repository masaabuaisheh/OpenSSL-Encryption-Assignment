@echo off

set "receiver=%~1"
set "sender=%~2"
set "filename=%~3"

if "%receiver%"=="" (
 echo Please provide the receiver's name.
 exit /b
)

if "%sender%"=="" (
 echo Please provide the sender's name.
 exit /b
)

if "%filename%"=="" (
 echo Please provide the filename.
 exit /b
)

echo Extracting %sender%'s public key...
openssl x509 -pubkey -in "C:\Users\user\Desktop\Network2openssl\openssl assignment\%sender%Certificate.pem" -out "%sender%PublicKey.pem"
if errorlevel 1 exit /b

echo Decrypting shared key...
openssl pkeyutl -decrypt -inkey "%receiver%PrivateKey.pem" -in Task2sharedkey.bin.enc -out "dec_sharedkey.bin"
if errorlevel 1 exit /b

echo Checking if the shared key file is empty...
if not exist "dec_sharedkey.bin" (
    echo Shared key file not found.
    exit /b
) else (
    for %%A in ("dec_sharedkey.bin") do set size=%%~zA
    if "!size!"=="0" (
        echo Shared key file is empty.
        exit /b
    ) else (
        echo Shared key file is present and not empty.
    )
)

echo Decrypting file...
openssl enc -aes-192-cbc -d -pbkdf2 -in "%filename%.enc" -out "%filename%.dec" -pass file:dec_sharedkey.bin
if errorlevel 1 (
 echo Decryption failed
 exit /b
) else (
 echo Decryption succeeded
)

echo Generating hash of decrypted file...
openssl dgst -sha512 -binary "%filename%.dec" > dec_hash.sha512
if errorlevel 1 exit /b

echo Verifying hash...
openssl pkeyutl -verify -in dec_hash.sha512 -sigfile Task2sign.sha512 -pubin -inkey "%sender%PublicKey.pem"
if errorlevel 0 (
echo Hash verification succeeded
) else (
echo Hash verification failed
)



REM Compare the original key with the decrypted key
FC.exe /B "C:\Users\user\Desktop\Network2openssl\openssl assignment\Task2sharedkey.bin" "dec_sharedkey.bin"

REM Compare the original file with the decrypted file
FC.exe /B "%filename%" "%filename%.dec"


