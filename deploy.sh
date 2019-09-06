docker build -t jahirbnavaz/multi-client:latest -t jahirbnavaz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jahirbnavaz/multi-server:latest -t jahirbnavaz/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t jahirbnavaz/multi-worker:latest -t jahirbnavaz/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push jahirbnavaz/multi-client:latest
docker push jahirbnavaz/multi-server:latest
docker push jahirbnavaz/multi-worker:latest

docker push jahirbnavaz/multi-client:$SHA
docker push jahirbnavaz/multi-server:$SHA
docker push jahirbnavaz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jahirbnavaz/multi-server:$SHA
kubectl set image deployments/client-deployment client=jahirbnavaz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jahirbnavaz/multi-worker:$SHA