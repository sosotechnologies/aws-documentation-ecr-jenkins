Firstly: Install Google-sdk in windows terminal

```
choco install gcloud-sdk
```

Secondly: Configure gcp against the CMD terminal

```
gcloud init
```

Using gcloud config 

```
gcloud config set project PROJECT_ID
gcloud config set compute/zone COMPUTE_ZONE
gcloud config set compute/region us-east4   //set the COMPUTE_REGION
gcloud components update   (optional)
gcloud auth login
```

Using gcloud init and SDK authenticatet     
$ gcloud init      //then follow the steps
gcloud init ( optional)--console-only
$ gcloud auth login

To view your projects and switch to a new project in cli
$ gcloud auth list                        //this will give you the list of accounts you are configured to
$ gcloud projects list                //will get the list of projects
# Supposedly your output list after running “gcloud projects list” is:

PROJECT_ID                                                  NAME                                           PROJECT_NUMBER
touchdown-baby-1010                  terraform-project                                123456789
common-fly-collins1112                ansible-project1                                  323453456
# If you want to work on the ‘touchdown-baby-1010’, run command gcloud config set project [project_ID]
$ gcloud config set project my-ssn-numberis-1010 
           
Next
#to work on k8s in windows
#Install kubectl in windows
$ choco install kubernetes-cli
$ choco install kubens
$ choco install kubectx

           OR
$ gcloud components install kubectl






  NEXT
 create a Kubernetes cluster. Move to visual code, it’s ideal  (code .)
#Configure kubernetes configuration file
#If creating a cluster names my-cluster
 #If cluster already exist, copy the cluster code and paste here

# create a zonal Kubernetes cluster called tesla-cluster in zone us-west2-a
$ gcloud container clusters create tesla-cluster --zone us-west2-a
 
# create a zonal standard Kubernetes cluster called tesla-cluster1 in zone us-central1-b and specify the number of nodes. Will create 3 vm instances and a cluster
$ gcloud container clusters create tesla-cluster1 --machine-type n1-standard-2 --num-nodes 2 --zone=us-central1-b --cluster-version latest  

#create an autopilot public cluster called tesla-cluster – switch to code . and  run in bash
$ gcloud container clusters create-auto tesla-cluster1 -–region=us-central1 --project= us-gcp-320723 
$ gcloud container clusters create-auto tesla-cluster --region=us-central1 --project=advance-engine-323116  

# Get the autopilot cluster credentials
$ gcloud container clusters get-credentials tesla-cluster --region us-central1 --project advance-engine-323116 -

#get the nodes running in the cluster
$ kubectl get nodes



# get the service account, this will be useful ror role, cluster and RBAC binding
# gcloud iam service-accounts describe [service_account]
$ gcloud iam service-accounts describe 478501398223compute@developer.gserviceaccount.com

Very important concept. This will be required when deploying ingress.
Granting Cloud Build access to GKE
To deploy the application in your Kubernetes cluster, Cloud Build needs the Kubernetes Engine Developer Identity and Access Management Role.
Get Project Number: (top left in console, click the 3-bars  click home) PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} --format='get(projectNumber)')"
478501398223="$(gcloud projects describe $advance-engine-323116 --format='get(projectNumber)')"


Add IAM Policy bindings:
# gcloud projects add-iam-policy-binding ${PROJECT_NUMBER} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/container.developer

$ gcloud projects add-iam-policy-binding $478501398223 --member=serviceAccount:$ 478501398223@cloudbuild.gserviceaccount.com  --role=roles/container.developer



