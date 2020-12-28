kubectl create namespace kubernetes-microservices

kubectl apply -n kubernetes-microservices -f kubernetes/secrets.yml

kubectl apply -n kubernetes-microservices -f kubernetes/mongo-deployment.yml
kubectl apply -n kubernetes-microservices -f kubernetes/mongo-service.yml

kubectl apply -n kubernetes-microservices -f kubernetes/flask-deployment.yml
kubectl apply -n kubernetes-microservices -f kubernetes/flask-service.yml

kubectl apply -n kubernetes-microservices -f kubernetes/sinatra-deployment.yml
kubectl apply -n kubernetes-microservices -f kubernetes/sinatra-service.yml

kubectl apply -n kubernetes-microservices -f kubernetes/ingress.yml
