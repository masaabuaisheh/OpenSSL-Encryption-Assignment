# OpenSSL-Encryption-Assignment
 This repository contains batch files for performing various encryption and decryption tasks using OpenSSL command line tools. Tasks include generating self-signed certificates, encrypting files with shared keys, computing and verifying hashes, and more.


### Task 1: Generate Self Signed Certificte and Private/Public Key Pair

#### Instructions:
1. Run `gen_cpp.bat` with your name as an argument.
   ```
   gen_cpp <yourname>
   ```
2. Follow the prompts to generate your private key, self-signed certificate, and extract your public key.
3. View the generated files `<YourName>Certificate.pem`, `<YourName>PrivateKey.pem`, and `<YourName>PublicKey.pem` using Notepad++ or Notepad.

### Task 2: Encrypt, hash, sign, using Public and Shared keys

#### Instructions:
1. Run `enc_file.bat` with the receiver's name, filename, and sender's name as arguments.
   ```
   enc_file <Receiver> <filename> <Sender>
   ```
2. Extract the receiver's public key from `<Receiver>Certificate.pem`.
3. Generate a shared key using `openssl rand` and encrypt it with the receiver's public key.
4. Encrypt the specified file with the shared key using AES-192-CBC algorithm.
5. Compute the SHA-512 hash of the encrypted file and sign it with the sender's private key.
6. Verify the signed hash with the sender's public key.

### Task 3: Decrypt the file and verify the Hash

#### Instructions:
1. Run `dec_file.bat` with the receiver's name, sender's name, and filename as arguments.
   ```
   dec_file <Receiver> <Sender> <filename>
   ```
2. Extract the sender's public key from their certificate.
3. Decrypt the encrypted shared key and compare it with the original key.
4. Decrypt the encrypted file using the shared key and compare it with the original file.
5. Compute the hash of the decrypted file.
6. Compare the computed hash with the signed hash using OpenSSL `pkeyutl`.

### Submission:
Create a folder containing:
- The 3 batch files (`gen_cpp.bat`, `enc_file.bat`, `dec_file.bat`).
- The encrypted test file (`hw3f23.pdf`).
- The signed hash file.
- Your certificate and your partner's certificate.
- Shared keys, signed hashes, and any other generated files.
Compress the folder into a RAR file and submit it.
