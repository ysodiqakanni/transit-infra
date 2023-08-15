# Pushing image to acr: 
Make sure to update the version when you tag and push

docker build -f Dockerfile -t transitapi:latest .       # to build the image
docker tag transitapi:latest sodiqtesttransitregistry.azurecr.io/transitapi:1.0.0
az acr login --name sodiqtesttransitregistry.azurecr.io
docker push sodiqtesttransitregistry.azurecr.io/transitapi:1.0.0 

## to run locally,
docker run -it -p 8845:80 transitapi:latest