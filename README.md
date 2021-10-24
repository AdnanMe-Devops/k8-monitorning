# k8-monitorning
Monitoring K8s with the Kubernetes Dashboard, Prometheus, and Grafana
In this  Step, 'll deploy a simple Python Flask web based API into the lab provided Kubernetes cluster. The API has been instrumented to provide various metrics which will be collected by Prometheus for observability 

In this  Step, will deployed a simple Python Flask web based API, which has been instrumented to automatically collect and provide metrics that will be collected by Prometheus. Additionally,  also deployed a single generator pod which will continually make HTTP requests against the API. In the  Step  will install and configure Prometheus.


In this  Step,will installed the Kubernetes Dashboard into the monitoring namespace within the Kubernetes cluster. will then setup and exposed the dashboard using a NodePort based Service. afterward  logged into the dashboard and confirmed that it was functional. 


Install and Configure Prometheus
will install and configure Prometheus into the provided Kubernetes cluster. Prometheus is an open-source systems monitoring and alerting service. w'll then configure Prometheus to perform automatic service discovery of both the API pods launched in the previous  Step, and the cluster's nodes. Prometheus will then automatically begin to collect metrics for both the API pods and the cluster's nodes. HTTP request based metrics will be collected from the API pods, and Memory and CPU utilisation metrics will be collected from the cluster's nodes. 


 will configure the Prometheus web admin interface to be exposed over the Internet on port 30900, allowing you to then access it from your own workstation.
api.py  Confirm that the following Targets are available


Install and Configure Grafana
In this  Step, going to install and configure Grafana into the monitoring namespace within the provided Kubernetes cluster. Grafana is an open source analytics and interactive visualization web application, providing charts, graphs, and alerts for monitoring and observability requirements. You'll configure Grafana to connect to Prometheus which you setup in the previous lab step as a data source. Once connected, w'll import and deploy a prebuilt Grafana dashboard.

 will also configure the Grafana web admin interface to be exposed over the Internet on port 30300, allowing you to then access it from  own workstation.
