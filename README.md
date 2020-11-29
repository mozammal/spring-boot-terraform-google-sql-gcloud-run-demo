# spring-boot-terraform-google-sql-gcloud-run-demo

This example shows how to run a hello world service on Google Run using Terraform

**Prerequisites:** [Java 11](https://adoptopenjdk.net/)

 [Terraform](https://www.terraform.io/)
 
 [Google SQL](https://cloud.google.com/sql)


## Getting Started

Terraform is used to create the Google Cloud Run infrastructure needed to deploy our hello world spring boot service. The following commands create the cloud infrastructure
and will eventually show the URL of the deployed service,

```bash
git clone https://github.com/mozammal/spring-boot-terraform-google-sql-gcloud-run-demo.git
cd spring-boot-terraform-google-sql-gcloud-run-demo
mvn clean compile jib:build 
cd terraform
terraform init
terraform plan
terraform apply
terraform output url
```

You’ve now come to the point where you can finally make post and get requests if you open the URL of the aforementioned deployed service on Google Cloud Run using terraform output url.


##### Create a contact
 
- [rest endpoint](https://{url}/customers)

- Method: POST
- example JSON payload
----

```json
{
  "firstName": "mozammal",
  "lastName": "hossain"
}

```

##### find all customers
 
- [rest endpoint](http://{url}/customers)

- endpoint: http://{url}/customers
- Method: GET 


Destroy the infrastructure that we created in the previous step by running the following command:
```
terraform destroy
```
