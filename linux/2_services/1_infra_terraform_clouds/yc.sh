#Install YC cli
# https://cloud.yandex.ru/docs/cli/operations/install-cli
#macos
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | zsh
source "~/.zshrc"
#linux with bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

#Configure YC in federation (company)
yc init --federation-id=YOUR_FEDERATION_ID


#SERVUCE ACCOUNTS
yc iam role list
yc iam service-account list
#create service account
yc iam service-account create --name my-robot
#get account info
yc iam service-account get my-robot


