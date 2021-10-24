
kubectl apply -f ./code/k8s

kubectl get pods

kubectl get svc

in order to generate traffic against the deployed API - spin up a single generator pod. In the terminal execute the following command:


kubectl run generator --env="API_URL=http://api-service:5000" --image=cloudacademydevops/api-generator --image-pull-policy IfNotPresent

Confirm that the generator pod is in a running status. In the terminal execute the following command:


kubectl get pods
-Create a new monitoring namespace within the cluster. In the terminal execute the following command:
kubectl create ns monitoring

Using Helm, install the Kubernetes Dashboard using the publicly available Kubernetes Dashboard Helm Chart. Deploy the dashboard into the monitoring namespace within the  provided cluster. In the terminal execute the following commands:


helm repo add k8s-dashboard https://kubernetes.github.io/dashboard
helm repo update
helm install k8s-dashboard --namespace monitoring k8s-dashboard/kubernetes-dashboard --set=protocolHttp=true --set=serviceAccount.create=true --set=serviceAccount.name=k8sdash-serviceaccount --version 3.0.2
}

Establish permissions within the cluster to allow the Kubernetes Dashboard to read and write all cluster resources. In the terminal execute the following command:


kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=monitoring:k8sdash-serviceaccount

The Kubernetes Dashboard web interface now needs to be exposed to the Internet so that you can browse to it. To do so, create a new NodePort based Service, and expose the web admin interface on port 30990. In the terminal execute the following command:


{
kubectl expose deployment k8s-dashboard-kubernetes-dashboard --type=NodePort --name=k8s-dashboard --port=30990 --target-port=9090 -n monitoring
kubectl patch service k8s-dashboard -n monitoring -p '{"spec":{"ports":[{"nodePort": 30990, "port": 30990, "protocol": "TCP", "targetPort": 9090}]}}'
}


Get the public IP address of the Kubernetes cluster that Prometheus has been deployed into . In the terminal execute the following command:


export | grep K8S_CLUSTER_PUBLICIP

Copy the Public IP address from the previous command and then using your local browser, browse to the URL: http://PUBLIC_IP:30990.



 Using Helm, install Prometheus using the publicly available Prometheus Helm Chart. Deploy Prometheus into the monitoring namespace within the  provided cluster. In the terminal execute the following commands:


{
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install prometheus --namespace monitoring --values ./code/prometheus/values.yml prometheus-community/prometheus --version 13.0.0
}


Confirm that Prometheus has been successfully rolled out within the cluster. In the terminal execute the following command:

kubectl get deployment -n monitoring -w

Confirm that the Prometheus Node Exporter DaemonSet resource has been created successfully. The Prometheus Node Exporter is used to collect Memory and CPU metrics off each node within the Kubernetes cluster. In the terminal execute the following command:


kubectl get daemonset -n monitoring

Patch the Prometheus Node Exporter DaemonSet to ensure that Prometheus can collect Memory and CPU node metrics. In the terminal execute the following command:


kubectl patch daemonset prometheus-node-exporter -n monitoring -p '{"spec":{"template":{"metadata":{"annotations":{"prometheus.io/scrape": "true"}}}}}'


The Prometheus web admin interface now needs to be exposed to the Internet so that you can browse to it. To do so, create a new NodePort based Service, and expose the web admin interface on port 30900. In the terminal execute the following command:


{
kubectl expose deployment prometheus-server --type=NodePort --name=prometheus-main --port=30900 --target-port=9090 -n monitoring
kubectl patch service prometheus-main -n monitoring -p '{"spec":{"ports":[{"nodePort": 30900, "port": 30900, "protocol": "TCP", "targetPort": 9090}]}}'
}


Get the public IP address of the Kubernetes cluster that Prometheus has been deployed into. In the terminal execute the following command:


export | grep K8S_CLUSTER_PUBLICIP

Copy the Public IP address from the previous command and then using your local browser, browse to the URL: http://PUBLIC_IP:30900.

Within Prometheus, click the Status top menu item and then select Service Discovery:


1. Using Helm, install Grafana using the publicly available Grafana Helm Chart. will deploy Grafana into the monitoring namespace within the provided cluster. In the terminal execute the following commands:


{
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana --namespace monitoring grafana/grafana --version 6.1.14
}

Confirm that the Grafana deployment has been rolled out successfully. In the terminal execute the following command:


kubectl get deployment grafana -n monitoring -w


The Grafana web admin interface now needs to be exposed to the Internet. To do so, create a new NodePort based Service, exposing the web admin interface on port 30900. In the terminal execute the following command:


{
kubectl expose deployment grafana --type=NodePort --name=grafana-main --port=30300 --target-port=3000 -n monitoring
kubectl patch service grafana-main -n monitoring -p '{"spec":{"ports":[{"nodePort": 30300, "port": 30300, "protocol": "TCP", "targetPort": 3000}]}}'
}


Extract the default admin password which will be required to login. In the terminal execute the following command:


kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

Get the public IP address of the Kubernetes cluster that Grafana has been deployed into. In the terminal execute the following command:


export | grep K8S_CLUSTER_PUBLICIP

Copy the Public IP address from the previous command and then using your local browser, browse to port http://PUBLIC_IP:30300.
