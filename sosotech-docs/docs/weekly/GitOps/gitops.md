# GitOps
my repo: [link](https://github.com/sosotechnologies/soso-flux)
## Example 1
- my Github name is: sosotechnologies
- Create a new repo called: infra
- create a github personal Access Token(classic) called: flux 
- Create a kubernetes cluster
- Bootstrap the cluster
- watch video: [link](https://www.youtube.com/watch?v=X9R5ySkiUkc)

save creds as env var

```
export GITHUB_TOKEN=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
export GITHUB_USER=sosotechnologies
export GITHUB_REPO=infra

 echo $GITHUB_USER
 echo $GITHUB_REPO
 echo $GITHUB_TOKEN
```

create an eks cluster


My terraform link: [LINK]()

bootstrap cluster, this bootstrap will also install flux

```
flux bootstrap github --owner=sosotechnologies --repository=sosoflux-infra --branch=main  --path=./florida/miami --personal true
```

You should see this structure in your github repo:

![gitops2](photos/gitops2.png)

***Next:***
- generate an ssh key from your ec2 terminal
- Go to your github --> settings --> SSH and GPG keys and paste [id_rsa.pub] content.
- clone the infra repo with [ssh]

```
ssh-keygen
cd .ssh
cat id_rsa.pub
```

```
git clone git@github.com:sosotechnologies/sosoflux-infra.git
cd sosoflux-infra
```

[ec2-user@ip-172-31-145-18 infra]$ ```tree```

```
.
└── florida
    └── miami
        └── flux-system
            ├── gotk-components.yaml
            ├── gotk-sync.yaml
            └── kustomization.yaml
```


add a demo folder and a yaml file in the folder

[ec2-user@ip-172-31-145-18 eks]$ ```cd florida```
[ec2-user@ip-172-31-145-18 eks]$ ```mkdir demo && cd demo && touch sosodocs.yaml```

```

└── florida
    └── miami
        ├── demo
        │   └── sosodocs.yaml
        └── flux-system
            ├── gotk-components.yaml
            ├── gotk-sync.yaml
            └── kustomization.yaml
```

commit these changes to your git repo

```
git add -A && \
git commit -m "added demo folder" && \
git push origin main
```

***Note:*** if you dont wanna wait for flux to deploy, use this command

```
flux reconcile kustomization flux-system --with-source
```

***NEXT***
IRSA
Get the OpenCD Connect Provider URL from the EKS cluster, use that to create an IDP in IAM

![IDp-add](photos/IDp-add.png)


***NEXT***
Create an IAM role and add the IDP.

![idp-add2](photos/idp-add2.png)


Give the AmazonEC2ContainerRegistryReadOnly PERMISSION TO THE ipd ROLE, Create role
![permiss](photos/permiss.png)

Go to the role and edit the trust policy
![trust](photos/trust.png)

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Federated": "arn:aws:iam::088789840359:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/4960280A882DD4D93CCCF19F4E3A32E7"
			},
			"Action": "sts:AssumeRoleWithWebIdentity",
			"Condition": {
				"StringEquals": {
					"oidc.eks.us-east-1.amazonaws.com/id/4960280A882DD4D93CCCF19F4E3A32E7:sub": "system:serviceaccount:flux-system:ecr-credentials-sync"
				}
			}
		}
	]
}

```

Copy the arn of the newly created role: ***arn:aws:iam::088789840359:role/FluxECRAccess***

***NEXT***
- Create a cron job. see the repo, my cronjob is in the file named ecr-job.yaml
- update the role arn in the ecr-job.yaml with your own role arn.

commit these changes to your git repo

```
git add -A && \
git commit -m "added demo folder" && \
git push origin main
```


***Note:*** if you dont wanna wait for flux to deploy, use this command

```
flux reconcile kustomization flux-system --with-source
```

Check to see that the cronjob was created: ```kubectl get cj -n flux-system```

Create a sample job since our cronjob is schedule for 6 hours intervals, and we can't wait.

```
k create job --from=cronjob/ecr-credentials-sync -n flux-system ecr-credentials-sync-init
```

```
kubectl get secret -n flux-system
kubectl get po -n flux-system
```

commit these changes to your git repo

[ec2-user@ip-172-31-145-18 infra]$ ```git add .```
[ec2-user@ip-172-31-145-18 infra]$ ```git commit -m "added demo folder"```
[ec2-user@ip-172-31-145-18 infra]$ ```git push```


***Note:*** if you dont wanna wait for flux to deploy, use this command

```
flux reconcile kustomization flux-system --with-source
```

***NOTE***
UNfortunately, I had an error: [✗ Kustomization reconciliation failed: ImagePolicy/flux-system/nginx dry-run failed, error: no matches for kind "ImagePolicy" in version "image.toolkit.fluxcd.io/v1alpha1"]


woerking on it
https://aws.amazon.com/blogs/containers/building-a-gitops-pipeline-with-amazon-eks/
```
flux create tenant soso-tenant4 --with-namespace team4 --export > soso4.yaml
```

https://devopstales.github.io/kubernetes/gitops-flux2/

Official flux: [Link](https://fluxcd.io/flux/cmd/flux/)



$ docker pull nginx:1.23.4

$ aws ecr get-login-password --region=us-east-1

***RESEARCH THIS IAM roles for service accounts(IRSA)***
Flux IRSA link: [LINK](https://fluxcd.io/flux/components/image/imagerepositories/)

When using IRSA to enable access to ECR, add the following patch to your bootstrap repository, 
in the flux-system/kustomization.yaml file:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - gotk-components.yaml
  - gotk-sync.yaml
patches:
  - patch: |
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: image-reflector-controller
        annotations:
          eks.amazonaws.com/role-arn: <role arn>      
    target:
      kind: ServiceAccount
      name: image-reflector-controller
```

## EX 2:
![arch](photos/arch.png)

- install GitHub Cli
- Create 4 repos: 
  - flux-production/apps
  - flux-staging/apps
  - flux-fleet[with-bootstrapping]
  - devops-toolkit/apps[repo-already-exists]
- clone them separately
- create namespaces: production and staging 
- create prod and staging source files in the [app] folder
- create a kustomization for prod and staging source files in the [app] folder


***Install Git Cli***

```
wget https://github.com/cli/cli/releases/download/v2.15.0/gh_2.15.0_linux_amd64.rpm

sudo rpm -i gh_2.15.0_linux_amd64.rpm

gh --version
```

copy key and create in Github-SSH, then authenticate GH

```
gh auth login
```

save Git creds as env var

```
export GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export GITHUB_USER=sosotechnologies
```

```
echo $GITHUB_USER
echo $GITHUB_TOKEN
```

### Repo 1. 

```
mkdir -p flux-production/apps
cd flux-production
git init
gh repo create

echo "commit Readme" | tee README.md

git add . && \
git commit -m "added prod folder" && \
git push --set-upstream origin master
```

### Repo 2
```
mkdir -p flux-staging/apps
cd flux-staging

git init
gh repo create

[Select: Push an existing local repository to GitHub]

echo "commit Readme" | tee README.md

git add . && \
git commit -m "added stag folder" && \
git push --set-upstream origin master
```


```
kubectl create ns production 
kubectl create ns staging 
```

### Repo 3
Remember the path defined here [apps] is the app folder I created in staging and production repos, bootstrap will:
- install flux
- Create a github repo
- create the deploy keys
...

```
flux bootstrap github --owner sosotechnologies --repository flux-fleet --branch main  --path apps --personal true
```

See the resources that were created from the bootstrap

```
kubectl get po -n flux-system
kubectl get svc -n flux-system
kubectl get secrets -n flux-system
kubectl get cm -n flux-system
```

#### Cd into flux-fleet directory and create the below resources

- staging source and Kustomization
- production source and Kustomization
- devops-toolkit

```
git clone git@github.com:sosotechnologies/flux-fleet.git
cd flux-fleet
```

So far my flux-weekend folder looks like so:

![arch2](photos/like-this2.png)

***Create Kustomization and Source in the flux-fleet/ folder***
- Create source and Kustomize for staging

```
flux create source git staging --url https://github.com/sosotechnologies/flux-staging --branch master --interval 30s --export | tee apps/staging.yaml
```

- Kustomize staging to same file: apps/staging.yaml

```
flux create kustomization staging --source staging --path "./" --prune true --interval 10m --export | tee -a apps/staging.yaml
```

***Create source and Kustomize for production***

```
flux create source git production --url https://github.com/sosotechnologies/flux-production --branch master --interval 30s --export | tee apps/production.yaml
```

Kustomize production to same file: apps/production.yaml

```
flux create kustomization production --source production --path "./" --prune true --interval 10m --export | tee -a apps/production.yaml
```

### repo 4
Create devops-toolkit in thesame in the flux-fleet/ folder

```
flux create source git devops-toolkit --url=https://github.com/sosotechnologies/devops-toolkit --branch=master --interval=30s --export | tee apps/devops-toolkit.yaml
```

```
git add . && \
git commit -m "added staging folder, production folder and devops-toolkit" && \
git push --set-upstream origin main
```

***Now my flux-weekend folder looks like***

![arch3](photos/like-this3.png)

```
watch flux get sources git
flux get kustomizations
```

***setup is done! NEXT: Create Helm Releases***

**Staging Release**

```
cd flux-staging
```

Copy this command and fun as is:

```
echo "image:
    tag: 2.9.9
ingress:
    host: staging.devops-toolkit.$INGRESS_HOST.nip.io" \
    | tee values.yaml
```

```
flux create helmrelease devops-toolkit-staging --source GitRepository/devops-toolkit --values values.yaml --chart "helm" --target-namespace staging --interval 30s --export | tee apps/devops-toolkit.yaml
```

```
rm values.yaml
```

```
git add . && \
git commit -m "added staging helm release" && \
git push --set-upstream origin master
```

```
watch flux get helmreleases
kubectl --namespace staging get pods
```

***NOTE:*** You can change the image tag in the staging: devops-toolkit.yaml
    From:  tag: 2.9.9 --> tag: 2.9.17 
And [commit and push to Git] and flux will automatically detect and deploy.


**Production Release**

```
cd ..
cd flux-production
```

Copy this command and fun as is:

```
echo "image:
    tag: 2.9.17
ingress:
    host: production.devops-toolkit.$INGRESS_HOST.nip.io" \
    | tee values.yaml
```

```
flux create helmrelease devops-toolkit-production --source GitRepository/devops-toolkit --values values.yaml --chart "helm" --target-namespace production --interval 30s --export | tee apps/devops-toolkit.yaml
```

```
rm values.yaml
```

```
git add . && \
git commit -m "added production helm release" && \
git push --set-upstream origin master
```

```
flux get helmreleases
watch kubectl --namespace production get pods
```

Final Tree

![arch4](photos/like-this4.png)

**IT'S ALL FOLKS!**

NEXT TASK

Configure ECR/OICD-IRSA/GIT tagging for CD deployment

```
aws ecr list-images --repository=soso-repository
```

```
kubectl create job --from=cronjob/ecr-credentials-sync -n flux-system ecr-credentials-sync-init --dry-run=client -o yaml > job.yaml
```

