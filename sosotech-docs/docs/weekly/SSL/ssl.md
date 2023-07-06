## I will use my image deployment and service for this demo

***deployment.yaml***

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: angels
  name: angels
  namespace: angelnamespace
spec:
  replicas: 1
  selector:
    matchLabels:
      app: angels
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: angels
    spec:
      containers:
      - image: sosotech/angelpalms:1.0.0
        name: angelpalms
        ports:
        - containerPort: 5000
        resources: {}
status: {}
```

***service.yaml***

```
k expose deploy angels --name=angel-svc -n angelnamespace --port=5000 --target-port=5000 --type=ClusterIP --dry-run=client -o yaml > service.yaml
```

```yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: angels
  name: angel-svc
  namespace: angelnamespace
spec:
  ports:
  - port: 5000
    protocol: TCP
    targetPort: 5000
  selector:
    app: angels
  type: ClusterIP
status:
  loadBalancer: {}
```

Check the helm url:[Helm Link](https://helm.sh/)
Check the istio url:[Istio Helm Link](https://istio.io/latest/docs/setup/install/helm/)

```
kubectl create ns istio-system
kubectl create ns angelnamespace
```

```
helm repo ls
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
helm search repo istio
helm ls -A
helm install istio-base istio/base -n istio-system
helm install istio-istiod istio/istiod -n istio-system
helm install istio-gateway istio/gateway -n istio-system
helm ls -A
kubectl get po -A
```

clone this repo: [TLS Yamls](https://github.com/sosotechnologies/sosokubernetes/tree/master/ssl-cert-istio-jenkins-minio-sonarqube)

***Get istio-ingressgateway deployment labels to add to the label area in below yaml***

```
kubectl get deploy -n istio-system
kubectl get deploy istio-gateway -n istio-system --show-labels
```

### gateway.yaml

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: general-gateway
  namespace: istio-system
  labels:
    app.kubernetes.io/instance: ingressgateway
    app: ingressgateway
    istio: ingressgateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - hosts:
    - '*'
    port:
      name: http
      number: 80
      protocol: HTTP
    # Upgrade HTTP to HTTPS
    tls:
      httpsRedirect: true
  - hosts:
    - '*'
    port:
      name: https
      number: 443
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: gateway-certs

      # app.kubernetes.io/managed-by=Helm
      # app.kubernetes.io/name=ingressgateway
      # app.kubernetes.io/version=1.16.1
      # app=ingressgateway
      # helm.sh/chart=gateway-1.16.1
      # istio=ingressgateway
```

### virtualservices.yaml

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  labels:
  name: angelpalms-vir-ser
  namespace: angelnamespace
spec:
  gateways:
  - istio-system/general-gateway     # This is the name and namespace from the gateway.yaml
  hosts:
  - 'angels.angelpalmshhcare.com'
  http:
  - retries:
      attempts: 3
      perTryTimeout: 2s
    match:
    - uri:
        prefix: /
    route:
    - destination:
        host: angel-svc.angelnamespace.svc.cluster.local    #first is angelpamls service name, second is namespace
        port:
          number: 5000
```

 

 sonarqube.skyfieldtechnologies.com
 jenkins.skyfieldtechnologies.com
 minio.skyfieldtechnologies.com