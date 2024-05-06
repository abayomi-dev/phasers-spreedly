# Phasers Worksample

This is a sample application designed to demonstrate how to use [Spreedly](https://phasers-spreedly.qa.arca-payments.network/) to collect money for one-off purchases using credit cards. Already Deployed in a Single one node cluster, Details are Below.



It uses the [httparty](https://github.com/jnunemaker/httparty) gem.


# Spreedly Application Deployment and automation.
![Basic High level workwlow](https://github.com/wasp-networks/spreedly-phasers/blob/master/PNG's/Spreedlt-Application.drawio.png)
The Diagram above shows the Basic worklow from the repository on github to the Internet</br>
![Application in cluster Low level](https://github.com/wasp-networks/spreedly-phasers/blob/master/PNG's/Workflow.png)
The Diagram above shows how the Users connect to the cluster via the NGINX Ingress Controller and the Ingress resource rules</br>

For a company that is very heavy on development having a DevOps process that works is of utmost importance, Below are stacks used. </br>
The following are the stacks used.</br>
- Kubernetes(EKS cluster)
- Docker 
- Jenkins
- AWS (Cloud hosting platform)

Even though every organizations has different stacks because of several factors like Compliance policies ETC, The objective remains the same </br>
### CICD
The CICD process or the continous integration and continous integration stage consists of the following steps:
- Checking out the image with organizational scans as setup on Jenkins UI.
- Building the images and pushing the a verieied image registry.
- installing necessary Dependencies needed for the Deployment phases.
![The Jenkins configuration after a successful deployment](https://github.com/wasp-networks/spreedly-phasers/blob/master/PNG's/Screenshot%202024-05-04%20at%2016.17.51.png)
**The Continuos Deployment phase**</br>
- This stage consists of a Deployment of the application into the kuberenetes single node cluster, which was deployed using terraform.
- This deployment is made to a test/QA environment as seen in the Jenkinsile script.

### Other Configurations
The several other different configurations that makes sure this application is served is deploying the ingress resources that exposes the services to the internet as seen in the diagram above </br>

The ingress controller is NGINX based and it helps process the rules , while the ingress.yaml as seen in the scripts are set of rules used to redirect the nginx loadabalancer to the services, hence, serving as a pathway/Gateway into which the services requests are processed.
![Ingress Resource in the Kubernetes UI](https://github.com/wasp-networks/spreedly-phasers/blob/master/PNG's/Screenshot%202024-05-04%20at%2016.55.03.png)
As seen in the picture we have the Kuberenetes UI(Lens) I am using for this test, show us that the service is mapped already to the appliation

Of course you might wonder where the HTTPS comes into the fray,</br> This is added in the ingress-controller file</br>
**HTTPS/Security and Code Scanning**</br>
`service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:eu-west-1:164135465533:certificate/1bc10b99-a0e3-4d3a-aeac-c6c3e0b17978
`</br>
This snippet shows us the portion at which the SSL cert is configured. We create a SAN or wildcard certificate and attach an ID possible AN ARN if we use AWS ACM for this provisioning and we will be able to work with the wildcarded domain name..</br>

After this is done on the AWS console we map the URL in this case phasers-spreedly.qa.arca-payments.network to the Loadbalacer that was created.

Other Details includes setting up a target group and attaching this tp the Loadbalancer that redirects HTTP to HTTPS.
The Scanning Operations using Trivy and CodeQL is to be Developed to be connected to all services. 
Security added to this tasks are.</br>
- CodeQL GitHub Dependencies scanning
- AWS ACM(TLS certificates)
- Image scanning with Trivy 

### Final Remarks
Even though the application code was already done and written we needed to configure the Jenkinsfile script as a CICD to deploy to the Kuberenetes service from the Jenkins Server.
The deploy.yaml contains the Deployment Resource configuration for the container runtime as weel as the service, which connects to the ingress resource for this microservice application.
The Process of automation could be done in several different ways but the most important thing is making sure that, the CICD stacks are provisioned meetime each companies need.


## How to run this application
When this setup has been completed you hit `build now on Jenkins or on your existing CICD platform` and it goes ahead to build the application into an image and serve it in kubernetes after which its accessible via the URL. Ofcourse a highly skilled DevOps personnel will be very important for this process to be Automated.

## Improvements

For a production ready Deployment on a large scale the Use of a more Robust Continous Integration and Delivery phase will be used, where we have an integrated for different environmets packaged into helm charts, And if the helm charts are multiple leading to increased complexity we make use of helmfiles to manage the corresponding helm charts making use of the Blue-Green Deployment style.

For more finegrained and smooter production use we use the following stacks.
- Terraform/OpenTOFU
- Helm charts/Helmfiles
- Jenkins/GitHUB Actions

Kindly review and thanks for reading through.