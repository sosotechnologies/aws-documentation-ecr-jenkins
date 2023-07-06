# EKS ADmins authentication to Clusters

## Setting UP Cluster IAM ***Groups*** for EKS Admins
1. STS Assume Role Trust Policy (STS Assume Role)
2. IAM Policy (EKS Fill Access)
3. IAM Role (you will add this rolearn to the cluster authentication-configmap)
4. IAM Group Policy (reference the IAM role)
5. IAM Groups (create Iam group called: ***sosoadmins***)

## Setting UP Cluster IAM ***Users*** for the Group
1. Create the users and add them to the ***sosoadmins*** group 
2. Ex: If you create these admins ***sosoadmin1***, ***sosoadmin2***, and add to the group, they will have access to the cluster


To get the users, run command:
  ```
  aws sts get-caller-identity
  ```