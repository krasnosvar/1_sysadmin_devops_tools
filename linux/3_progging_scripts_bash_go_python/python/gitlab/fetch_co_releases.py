"""
release fetcher
fetches 'releases config' from release branches
and puts it into QA config infrasructure repos
works with two projects:
1. *Project*- releases
2. *Terraform Stand Creator* for Application(CO)
"""

import gitlab
import re
import os
# https://stackoverflow.com/questions/27981545/suppress-insecurerequestwarning-unverified-https-request-is-being-made-in-pytho/33716188
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


read_token = os.environ['READ_CO_TOKEN']
write_token = os.environ['WRITE_GL_TOKEN']
terraform_repo_id = 4912
profiles_repo_id = 4476

"""
Class to fetch objects from Gitlab
"""

class GlProgect:
    def __init__(self, gl_repo_id=terraform_repo_id, gl_repo_token=write_token):
        self.gl_repo_id = gl_repo_id
        self.gl_repo_token = gl_repo_token
        self.gl = gitlab.Gitlab('https://gitlab.local', private_token=gl_repo_token, ssl_verify=False)

    def project_get(self):
        project_id = self.gl_repo_id
        project_gett = self.gl.projects.get(project_id)
        return project_gett # returns project as object( from gitlab lib)

    def branche_list(self):
        project_id = self.gl_repo_id
        project_get = self.gl.projects.get(project_id)
        br_list_as_class = project_get.branches.list()  # return branch-list as class object
        branch_as_clean_list = []
        for branch_name in br_list_as_class:  # fetch objects as dict fron list "branches"
            branch_uniq = getattr(branch_name, "name")  # https://www.geeksforgeeks.org/accessing-attributes-methods-python/
            branch_as_clean_list.append(branch_uniq)  # create list of all branches
        return branch_as_clean_list


profiles_branches = GlProgect(profiles_repo_id, read_token).branche_list()
print(f"List all Branches of Profiles Repo \n {profiles_branches}")
terraform_branches = GlProgect().branche_list()
print(f"List all Branches of Terra Repo \n {terraform_branches}")


#fetch only uniq branches and add them to repo
def fetcher_br_to_terra(profiles_branches, terraform_branches):
    result = set(profiles_branches) - set(terraform_branches)  # https://stackoverflow.com/questions/28444561/get-only-unique-elements-from-two-lists
    for add_brancito in result:
        # conditional to add only 'release' branches
        if "release" in add_brancito:
            print(f"Branches to add to Terra Repo \n {add_brancito}")
            # build config filename
            uniq_branch_wo_release = re.sub(r'release/', "", add_brancito)
            file_name = (f"{uniq_branch_wo_release}.config")
            get_config = GlProgect(profiles_repo_id, read_token).project_get().files.get(file_path=file_name, ref=add_brancito)
            # config_content = get_config.decode()
            config_content = get_config.content
            # create branch by release and put into in config-file
            new_branch = GlProgect().project_get().branches.create({'branch': add_brancito, 'ref': 'master'})
            f = GlProgect().project_get().files.create({'file_path': file_name,
                                            'branch': add_brancito,
                                            'content': config_content,
                                            # 'author_email': 'user@domain.local',
                                            # 'author_name': 'user',
                                            'encoding': 'base64',
                                            'commit_message': f'add {file_name}'})


fetcher_br_to_terra(profiles_branches, terraform_branches)
