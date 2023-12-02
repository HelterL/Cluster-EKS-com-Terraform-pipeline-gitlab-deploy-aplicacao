# Criação de um cluster AWS EKS kubernetes com Terraform e Pipeline com gitlab 

## O que utilizei?

- Terraform
- Gitlab CI
- AWS
- Docker
- Kubernetes
- PHP
- AWS CLI

## Como funciona?

- O Terraform provisiona o cluster EKS e toda a rede necessária
- Gitlab automatiza a criação do container docker, push para o docker hub e finalmente faz o deploy do container dentro do cluster EKS
- Eles trabalham juntos em um pipeline no Gitlab CI.

## Pré-requisitos

- Conta na AWS
- Conta no gitlab
- Criação das seguintes variáveis de ambiente no projeto/repo gitlab
- AWS_ACCESS_KEY_ID (Chave aws access key)
- AWS_SECRET_ACCESS_KEY (Chave aws secret access key)
- DOCKER_REGISTRY_USER (email ou usuário do docker hub)
- DOCKER_REGISTRY_PASS (senha do docker hub)
- Kubectl instalado localmente

## Provisionando o ambiente com Terraform

Certifique-se de já ter instalado a AWS-CLI e a mesma configurada com suas chaves

Crie um bucket S3 com o nome de sua preferência e troque o nome dentro do arquivo main.tf com o nome do seu bucket

Após isso, utilize o comando terraform init para inicializar a configuração

```bash
Terraform init
```

Utilize o comando terraform plan para verificar se há algum erro na criação dos recursos

```bash
Terraform plan -out plan.tfplan
```

e por fim terraform apply plan.tfplan para criar os recursos

```bash
Terraform apply plan.tfplan
```

Crie as variáveis de ambiente no gitlab, após isso basta fazer um commit para rodar a pipeline.

## Acesso ao cluster kubernetes

Para acessar o cluster utilize o seguinte comando:

```bash
aws eks --region us-east-1 update-kubeconfig --name ekscluster
```

Comando para verificar os pods

```bash
kubectl get pods
```

Configuração do banco de dados, após esse comando será mostrado o pod mysql, utilize o seguinte comando para se conectar

```bash
kubectl exec -ti nomedopodmysql /bin/bash
```

dentro do pod, utilize o seguinte comando e após isso coloque a senha que é password

```bash
mysql -u root -p
```

Criação do banco de dados e tabela

```bash
CREATE DATABASE meubanco;
```

```bash
USE meubanco;
```

```bash
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(220),
    email VARCHAR(220),
    created DATETIME,
    modified DATETIME NULL
);
```

Comando para mostrar os serviços em execução

```bash
kubectl get svc
```

Para verificar se tudo ocorreu como esperado, após esse comando será mostrado o DNS do lb-app que é loadbalancer do nosso aplicativo, para acessar basta copiar o DNS e colar no seu navegador.

Adicione um usuário e verifique dentro do banco de dados, utilizando os comando para se conectar e por fim utilize o comando para verificar se deu certo

```bash
SELECT * FROM usuarios;
```

Comando para verificar os nós

```bash
kubectl get nodes
```

Comando para verificar os deploy

```bash
kubectl get deployment
```

## Destruir recursos

Delete os serviços criados junto com os deploy

```bash
kubectl delete svc lb-app mysql
```

```bash
kubectl delete deploy app2 mysql
```

Por fim, destrua os recursos cridados na AWS

```bash
terraform destroy
```
Após esse comando confirme digitando "yes"

