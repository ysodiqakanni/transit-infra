The tf scripts here are used to setup the main azure resources for the application and the server it's deployed to.
- we setup an ACR to hold the docker images for the app
- we setup an app service that that runs a container based off our specified image from the ACR
