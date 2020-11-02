docker build -t mkawtharani/multi-client:latest -t mkawtharani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mkawtharani/multi-server:latest -t mkawtharani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mkawtharani/multi-worker:latest -t mkawtharani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mkawtharani/multi-client:latest
docker push mkawtharani/multi-server:latest
docker push mkawtharani/multi-worker:latest

docker push mkawtharani/multi-client:$SHA
docker push mkawtharani/multi-server:$SHA
docker push mkawtharani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mkawtharani/multi-server:$SHA
kubectl set image deployments/client-deployment client=mkawtharani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mkawtharani/multi-worker:$SHA