# Azure 
Free azure account and go to the postal link:

- [Free account-Link](https://azure.microsoft.com/free/)
- [Portal-Link](https://portal.azure.com/)

## Whats hierarchy

Azure provides four levels of management: 
***management groups -> Subscriptions -> Resource Groups -> Resources***
 ![hierarchy](photos/hierarchy.png)

- ***Management groups*** help you manage access, policy, and compliance for 
multiple subscriptions. All subscriptions in a management group automatically 
inherit the conditions that are applied to the management group.
- ***Subscriptions*** associate user accounts with the resources that they create. 
- ***Resource groups*** are logical containers where you can deploy and manage 
Azure resources like web apps, databases, and storage accounts.
- ***Resources*** are instances of services that you can create, such as virtual 
machines, storage, and SQL databases.

### Set a budget
  ![budget](photos/budget.png)

### Azure Storage types
Azure Storage offers five core services:

- ***Blob Storage*** helps you create data lakes for your analytics needs, and provides storage 
 to build powerful cloud-native and mobile apps.
- ***File Storage***: Managed file shares for cloud or on-premises deployments.
- ***Queue Storage***: A messaging store for reliable messaging between application components.
- ***Table Storage***: A NoSQL store for schemaless storage of structured data.
- ***Managed Disk Storage***: Block-level storage volumes for Azure VMs.
- ***Azure Elastic SAN (preview)***: A fully integrated solution that simplifies deploying, 
scaling, managing, and configuring a SAN in Azure.

Azure also offers a list of SQL Data and non-SQL Databases.
For More on Azure Storage, see link: [Azure Storage Link](https://learn.microsoft.com/en-us/azure/storage/common/storage-introduction)

### Azure Networking Service
For More on Azure networking, see link: [Azure networking Link](https://learn.microsoft.com/en-us/azure/networking/fundamentals/networking-overview)

## Azure and Terraform
Azure provder Terraform link: [Terraform link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

### Azure authentication from the terminal
```
az login
az account list
az account list --query [*].[name,id]
```

In azure terminal - bash, 
  - Create an AD service principle for RBAC  using below command, 
  - Next, go to subscriptions and get the subscription ID.

```
az ad sp create-for-rbac -n "Terraform-Soso" --role="Contributor" --scopes="/subscriptions/b965a029-32b4-4671-b283-350344c89091"
```

Go to azure ***app registration*** and see that it was created.
Copy the info created. In my case:

```
{
  "appId": "297ec591-b16e-42ce-9e03-1ebd725aa3f9",
  "displayName": "Terraform-Soso",
  "password": "FZG8Q~-uPKCxRNgIg8JVAKYO2xm4j..S1SpFoaxg",
  "tenant": "054da2e5-2fbf-483f-961e-a3b2839bd53c"
}
```

## Azure Active Directory
Azure AD part of Microsoft [Entra](https://www.microsoft.com/en-us/security/business/microsoft-entra), is an identity and Access Management service that provides single sign-on, multifactor 
authentication, and conditional access to guard against 99.9 percent of cybersecurity attacks.

### Accounts and subscriptions
- ***Account:*** 
- ***Subscription:***
- ***Tenant:***
- ***Resource Groups:***

#### users
There are three types of user accounts that you can have in Azure AD:
***federated***
***synchronized***
***cloud***

#### Optional: Create a new tenant for your organization
For more info see: [To create a new tenant](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-access-create-new-tenant)

After creating tenant, it comes with nothin installed, so I will have to add subscriptions...
***Note***: You can switch between tenants
## Storage
### Storage Access Control (IAM)