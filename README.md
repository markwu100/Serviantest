# This is a high level explanation for the technical test provided by servian



### 1. The Architecture of the system

#### **Security**

The codes created in this repository are all base on the system architecture shown in Figure1.  In order to provide a secure and consolidate infrastructure for our business, I create a two-tier network with 2 public subnets and two private subnets. The application server located in the public subnets are allowed to communicate with the internet while the postgreSQL database in the private subnets are only accesible by the application server in the public subnet.



I have also created three different SG for ALB, application server and datebase respectively. In doing so, we could make sure that both application and database servers are only allow to be accessed by specific host and invisible to the public traffic. 

In order to encrypt the crendential file to access AWS cloud and spin up the infrastructure, I have used variables in the code. Feel free to generate your own personal credential for AWS and get you own access key and secret access key.  Then you can type in these two secret when you use 'terrform plan' or 'terraform apply' to run the code. 



#### **High Availability & Scalability**



#### **Automation**









### 2. The way to run the code 





This terraform code creates an entire VPC network, a postgreSQL database,  launch configuration, auto scaling group and an ALB. The ALB listens on port 80. 

The example uses latest Ubuntu AMIs.

To run, configure your AWS provider as described in <https://www.terraform.io/docs/providers/aws/index.html>

**Running the test code :** 

1. Go to your working directory and type in the command below to download the binary code and rename the repo to  terraform.

```
git clone https://github.com/markwu100/Serviantest.git terraform 
```

2. Initiate the Repository

```
terraform init
```

3. For planning phase

```
terraform plan -var 'access_key={your_access_key}' -var 'secret_access_key={your_secret_key}'
```

4. For apply phase

```
terraform apply -var 'access_key={your_access_key}' -var 'secret_access_key={your_secret_key}'
```

5. After you run the above code you will get two following outputs. Once the stack is created, wait for few minutes and test the stack by launching a browser with ALB url.  Open a Chrome web browser, and the type in the alb_dns_name listed below, you will then be directed to the landing page of the website. 

```
Outputs:

alb_dns_name = servian-techtest-alb-195736887.ap-southeast-2.elb.amazonaws.com
db_endpoint = demodb-postgres.cc6m3cifzpdr.ap-southeast-2.rds.amazonaws.com:5432
```

![](/Users/mark/Desktop/capture1.jpg)

To remove the stack

```
 terraform destroy  -var 'access_key={your_access_key}' -var 'secret_access_key={your_secret_key}'
```