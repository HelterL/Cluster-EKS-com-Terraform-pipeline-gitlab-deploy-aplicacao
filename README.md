# Criação de um cluster AWS EKS kubernetes com gitlab terraform

## O que utilizei?

- Terraform
- Gitlab CI
- AWS
- Docker
- Kubernetes
- PHP

## Como funciona?

- O Terraform provisiona o cluster EKS e toda a rede necessária
- Gitlab automatiza a criação do container docker, push para o docker hub e finalmente faz o deploy do container dentro do cluster EKS
- Eles trabalham juntos em um pipeline no Gitlab CI.

## Pré-requisitos

- Conta na AWS
- Conta no gitlab
- Criação das seguintes variáveis de ambiente no gitlab
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- DOCKER_REGISTRY_USER
- DOCKER_REGISTRY_PASS

## Rodando a pipeline

Após a criação das variáveis de ambiente, basta fazer um commit para rodar a pipeline.

Primeiro será a criação do ambiente com terraform, após isso será a instalação e configuração do ambiente kubernetes com ansible

## Acesso ao cluster kubernetes

Para acessar o cluster vá nas instâncias criadas na AWS, procure a instância com a tag master
ela é o nosso nó control plane, os outros são workers

Basta acessar a máquina através da chave .pem como de costume e utilizar o comando sudo su para entrar no modo root

Exibindo nós criados

```bash
kubectl get nodes
```

Exibindo pods do namespace kube-system

```bash
kubectl get pods -n kube-system
```
