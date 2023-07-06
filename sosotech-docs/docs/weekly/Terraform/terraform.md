# Terraform Working Links
for more information see link: [Sosotech Terraform Repo](https://github.com/sosotechnologies/soso-terraform)

For deploying Helm Charts with Terraform: [Helm, Terraform, Jenkins](https://github.com/sosotechnologies/terraform-helm-jenkins)


## Github Repositories used for this course
- [Terraform on AWS EKS Kubernetes IaC SRE- 50 Real-World Demos](https://github.com/stacksimplify/terraform-on-aws-eks)
- [Course Presentation](https://github.com/stacksimplify/terraform-on-aws-eks/tree/main/course-presentation)
- [Kubernetes Fundamentals](https://github.com/stacksimplify/kubernetes-fundamentals)
- **Important Note:** Please go to these repositories and FORK these repositories and make use of them during the course.


Scorage class: [Link](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class_v1)

Persistent volume: [Link](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume)

   **Note**. You Must have an understanding of ***volume_handle*** - (Required) A map that specifies static properties of a volume. For more info see Kubernetes reference. This is the way I am mapping the EFS I.D  to the Volume.
   The volume handles is not neccessary for dynamic provisioning, because you will not creating a PV file, and you will be using storage Provisioner to dynamically create the PV's. Pass the provisioner in your storage Class Object.

For your mount_path = "/data", any data in the mountpath will be store in your EFS. You can name to whatever u choose

```k exec --stdin --tty soso-pod --/bin/sh```

MY ADVISE - use different S3 buckets for critical backends, so If an s3 is mistakenly deleted some how, you can create a new bucket and re-initialize that specific resource group.

For modules: [See link](https://www.bogotobogo.com/DevOps/Terraform/Terraform-modules.php)

### StateFile
```terraform state list