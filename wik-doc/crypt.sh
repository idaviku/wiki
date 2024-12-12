#!/bin/bash

#KEY="tu_clave_secreta"  

encrypt_file() {
    local file_path="$1"
    openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -salt -in "$file_path" -out "$file_path.enc" -k $tmp_key_crypt
    if [ $? -eq 0 ]; then
        rm "$file_path"
    else
        echo "Error encriptando el archivo $file_path"
    fi
}

decrypt_file() {
    local file_path="$1"
    openssl enc -aes-256-cbc -d -pbkdf2 -iter 100000 -in "$file_path" -out "${file_path%.enc}" -k $tmp_key_crypt
    if [ $? -eq 0 ]; then
        rm "$file_path"
    else
        echo "Error desencriptando el archivo $file_path"
    fi
}

if [ "$1" == "encrypt" ]; then
    encrypt_file "$2"
elif [ "$1" == "decrypt" ]; then
    decrypt_file "$2"
else
    echo "Uso: $0 {encrypt|decrypt} archivo"
fi
