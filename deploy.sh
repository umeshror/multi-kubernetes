docker build -t umeshvjti/multi-client:latest -t umeshvjti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t umeshvjti/multi-server:latest -t umeshvjti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t umeshvjti/multi-worker:latest -t umeshvjti/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push umeshvjti/multi-client:latest
docker push umeshvjti/multi-server:latest
docker push umeshvjti/multi-worker:latest

docker push umeshvjti/multi-client:$SHA
docker push umeshvjti/multi-server:$SHA
docker push umeshvjti/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=umeshvjti/multi-server:$SHA
kubectl set image deployments/client-deployment client=umeshvjti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=umeshvjti/multi-worker:$SHA