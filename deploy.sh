docker build -t djam97/multi-client:latest -t djam97/multie-client:$SHA -f ./client/Dockerfile ./client
docker build -t djam97/multi-server:latest djam97/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t djam97/multi-worker:latest djam97/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push djam97/multi-client:latest
docker push djam97/multi-server:latest
docker push djam97/multi-worker:latest

docker push djam97/multi-client:$SHA
docker push djam97/multi-server:$SHA
docker push djam97/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=djam97/multi-client:$SHA
kubectl set image deployments/server-deployment server=djam97/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=djam97/multi-worker:$SHA