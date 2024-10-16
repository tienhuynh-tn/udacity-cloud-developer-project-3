kubectl delete deployment frontend
kubectl delete service frontend
kubectl delete service frontend-ep
kubectl delete deployment backend-user
kubectl delete services backend-user
kubectl delete deployment backend-feed
kubectl delete services backend-feed
kubectl delete deployment reverseproxy
kubectl delete services reverseproxy
kubectl delete services reverseproxy-ep

kubectl delete hpa backend-user

kubectl apply -f aws-secret.yaml --request-timeout=120s
kubectl apply -f env-secret.yaml --request-timeout=120s
kubectl apply -f env-configmap.yaml --request-timeout=120s

kubectl apply -f backend-feed-deployment.yaml --request-timeout=120s
kubectl apply -f backend-feed-service.yaml --request-timeout=120s
kubectl apply -f backend-user-deployment.yaml --request-timeout=120s
kubectl apply -f backend-user-service.yaml --request-timeout=120s
kubectl apply -f reverseproxy-deployment.yaml --request-timeout=120s
kubectl apply -f reverseproxy-service.yaml --request-timeout=120s
kubectl expose deployment reverseproxy --type=LoadBalancer --name=reverseproxy-ep --port=8080

kubectl apply -f frontend-deployment.yaml --request-timeout=120s
kubectl apply -f frontend-service.yaml --request-timeout=120s
kubectl expose deployment frontend --type=LoadBalancer --name=frontend-ep

kubectl get deployments
kubectl get services
kubectl get pods

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl autoscale deployment backend-feed --cpu-percent=70 --min=2 --max=3
kubectl describe hpa
