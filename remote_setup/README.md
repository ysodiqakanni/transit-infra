the files here are used to setup neccessary resources on azure and github.
Basically, to run our tf jobs in a CD pipeline like github actions, we need to authenticate to Azure by creating a service principal account. We also need to save the terraform state file, we will save this in azure storage account.

Out github repo will also need some secrets to function.
Running terraform apply here will create all resources mentioned above.

Prerequisite:
- Create a Personal Access Token using this link: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
