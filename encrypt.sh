#! /bin/bash

printf "Your access token: "
read -s token
printf "\r"

openssl rsautl -encrypt -pubin -inkey public_key.pem <<< "$token" | base64
