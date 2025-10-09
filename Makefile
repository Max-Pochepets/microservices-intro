image-build:
	SERVICE_TAG=1.0.0 PSQL_TAG=13.20-alpine3.21 docker compose build resources-ms songs-ms songs-db resources-db

container-start:
	$(MAKE) image-build
	kubectl apply -f k8s/

kube-init:
	docker run -d --restart=always -p 127.0.0.1:23750:2375 -v /var/run/docker.sock:/var/run/docker.sock  alpine/socat  tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
	minikube start
	eval $(minikube docker-env)
	$(MAKE) container-start
	kubectl config set-context --current --namespace=microservices

kube-stop:
	kubectl delete -f k8s/
	docker rm -f $(docker ps -aq)
	docker system prune -f
	eval $(minikube docker-env -u)
	minikube stop
