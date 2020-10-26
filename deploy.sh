docker build -t mkawtharani/multi-client -f ./client/Dockerfile ./client
docker build -t mkawtharani/multi-server -f ./server/Dockerfile ./server
docker build -t mkawtharani/multi-worker -f ./worker/Dockerfile ./worker
docker push mkawtharani/multi-client
docker push mkawtharani/multi-server
docker push mkawtharani/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mkawtharani/multi-server
