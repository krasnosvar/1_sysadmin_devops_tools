# curl -sX GET 'https://ossnexus.repo.ru/service/rest/v1/components?repository=repo-raw&continuationToken=71afea540e23dde53e6d65cbea9e8e84'|jq
'''
скрипт берет переменную $SENCHA_VER и выводит ссылки на скачивание сенчи в репозитории
export SENCHA_VER=7.4.0
'''
import requests
import os
import json
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def get_links(json_data1):
    for repos_ids in json_data1.get('items', []):
        for repos_urls in repos_ids.get('assets', []):
            downloadUrl = repos_urls.get('downloadUrl', '')
            if "sencha" and os.environ['SENCHA_VER'] in downloadUrl:
                print(downloadUrl)


nexus_api_repo_url = "https://ossnexus.repo.ru/service/rest/v1/components?repository=repo-raw"
#fetch token
nexus_api_repo_json_output = requests.get(nexus_api_repo_url, verify=False).json()
next_url_token=nexus_api_repo_json_output["continuationToken"]
while next_url_token:
    # set url with token
    nexus_api_repo_url_with_token = (f"{nexus_api_repo_url}&continuationToken={next_url_token}")
    nexus_api_repo_json_output = requests.get(nexus_api_repo_url_with_token, verify=False).json()
    next_url_token=nexus_api_repo_json_output["continuationToken"]
    # print(next_url_token)
    get_links(nexus_api_repo_json_output)
