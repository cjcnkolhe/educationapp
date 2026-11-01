# Education Management System

Spring Boot 3 + Java 17 + JSP + Spring Data JPA. Includes student CRUD, local H2, optional MySQL, Maven, SonarQube, Docker, Jenkins, Ansible, Terraform and Kubernetes examples.

## Run locally
Requirements: JDK 17 and Maven 3.8+.
```bash
mvn clean package
java -jar target/educationapp.war
```
Open http://localhost:8080/. The project uses WAR packaging for JSP. Test the WAR with the same Tomcat 10.1 runtime used in Docker.

## Docker
```bash
mvn clean package
docker build -t educationapp:1 .
docker run --rm -p 8080:8080 educationapp:1
```

## SonarQube
```bash
docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community
mvn clean verify sonar:sonar -Dsonar.projectKey=educationapp -Dsonar.host.url=http://localhost:9000 -Dsonar.token=YOUR_TOKEN
```
Configure Jenkins SonarQube webhook to `/sonarqube-webhook/`.

## GitHub
```bash
git init
git add .
git commit -m "Initial education app"
git branch -M main
git remote add origin https://github.com/USERNAME/educationapp.git
git push -u origin main
```

## Ansible
Copy `ansible/inventory.ini.example` to `ansible/inventory.ini`, set host, SSH user and key path.
```bash
ansible -i ansible/inventory.ini all -m ping
ansible-playbook -i ansible/inventory.ini ansible/setup-ubuntu-tools.yml
```
This playbook prepares an Ubuntu Jenkins agent with Java, Git, Maven and Docker. It does not install Jenkins itself.

## Terraform / EKS
Review the Terraform files first. EKS, EC2, NAT Gateway and load balancers are billable.
```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
Check that the selected Kubernetes version is currently supported in your AWS region before applying.
```bash
aws eks update-kubeconfig --region ap-south-1 --name education-cluster
kubectl get nodes
```

## Kubernetes
Replace `DOCKERHUB_USERNAME` in `k8s/deployment.yaml`.
```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods -n education
kubectl get svc -n education
```
The LoadBalancer Service needs AWS load-balancer integration, correct subnet tags and IAM permissions.

## Jenkins
Configure Jenkins tools named `JDK17` and `Maven3`; SonarQube server named `SonarQube`; Docker Hub username/token credential ID `dockerhub-credentials`. Edit image, AWS region and EKS cluster in `Jenkinsfile`. Give the Jenkins agent an IAM role and least-privilege EKS permissions. Create the initial namespace/deployment/service before running the pipeline.

Pipeline: checkout -> Maven build/test -> SonarQube -> quality gate -> Docker build/push -> Kubernetes rollout.


