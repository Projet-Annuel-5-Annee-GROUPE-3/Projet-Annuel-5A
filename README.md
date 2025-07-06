# Projet-Annuel-5A

# 📦 Projet Annuel - GadgetSphere 

Ce projet a été réalisé dans le cadre du projet annuel de l'année 2024-2025 par le groupe 3 : Evan QUERE, Donia MOKADEM, Corentin FOURCAUD

## 📚 Description

GadgetSphere est une entreprise innovante spécialisée dans la conception et la vente de gadgets technologiques et écologiques, destinés au grand public. Présente sur l’ensemble du territoire national, elle souhaite moderniser son infrastructure IT, renforcer sa sécurité et soutenir sa croissance à travers une transformation numérique écoresponsable. 

Dans le cadre de sa transformation numérique, GadgetSphere a pour objectif de : 

- Moderniser son système d'information (SI). 

- Externaliser plusieurs processus IT vers des solutions cloud et hybrides. 

- Améliorer la résilience, la sécurité et la supervision de son infrastructure. 

- Intégrer des pratiques durables et évolutives dans son infrastructure IT. 

## 🏗️ Architecture du projet

- `main.tf` : fichier principal 
- `ansible/` : répertoire contenant les playbooks Ansible d'installation des agents (automatisation)
- `powerhsell/` : scripts shell pour la supervision de l'Active Directory
- `cluster-kubernetes-azure/` : code Terraform de l'installation d'un cluser Kubernetes sur Azure avec un seul node  
- `Terraform-Kube-argoCD/` : code Terraform de l'installation d'un cluser Kubernetes (EKS) sur AWS avec 3 nodes et hébérgement d'un site web
- `supervision` : scripts et codes pour la mise en place de la supervision (Prometheus, RocketChat...)
