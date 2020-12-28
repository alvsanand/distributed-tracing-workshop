kubectl create namespace hotrod

K8S_INGRESS_IP=$(kubectl get -n observability ingress -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: app
    app.kubernetes.io/instance: hotrod
  name: hotrod-app
  namespace: hotrod
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/component: app
      app.kubernetes.io/instance: hotrod
      app.kubernetes.io/name: hotrod-app
  template:
    metadata:
      labels:
        app.kubernetes.io/component: app
        app.kubernetes.io/instance: hotrod
        app.kubernetes.io/name: hotrod-app
    spec:
      containers:
      - env:
        - name: JAEGER_AGENT_HOST
          value: jaeger-workshop-agent.observability.svc.cluster.local
        - name: JAEGER_AGENT_PORT
          value: "6831"
        image: jaegertracing/example-hotrod:latest
        imagePullPolicy: Always
        args: ["all", "-j", "http://$K8S_INGRESS_IP"]
        livenessProbe:
          httpGet:
            path: /
            port: 8080
        name: jaeger-hotrod
        ports:
        - containerPort: 8080
        readinessProbe:
          httpGet:
            path: /
            port: 8080
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: service
    app.kubernetes.io/instance: hotrod
  name: hotrod-service
  namespace: hotrod
spec:
  selector:
    app.kubernetes.io/component: app
    app.kubernetes.io/instance: hotrod
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
EOF