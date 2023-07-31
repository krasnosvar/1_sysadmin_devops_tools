import json

with open('repoSizes-20210519-020402.json') as f:
    data = json.load(f)


# for key in data:
#     if key == 'KRSUA':
#         for repo in data[key]:
#             if repo == 'repositories':
#                 for i in data[key][repo]:
#                     for size in data[key][repo][i]:
#                         if size == 'totalBytes':
#                             repo_gb = (data[key][repo][i][size])/1024/1024/1024
#                             repo_size_pretty = "{:.2f}".format(repo_gb)
#                             print(f"{i} - {repo_size_pretty}Gb")

# v2
for key, item in data.get("KRSUA", {}).get("repositories", {}).items():
    if item.get("totalBytes") is None:
        continue
    repo_gb = item.get("totalBytes")/1024/1024/1024
    repo_size_pretty = "{:.2f}".format(repo_gb)
    print(f"{key} - {repo_size_pretty}Gb")
