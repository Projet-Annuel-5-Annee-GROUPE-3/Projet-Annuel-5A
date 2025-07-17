#!/bin/bash

set -e

ACTION=$1

if [[ "$ACTION" == "deploy" ]]; then
  echo "🛠️ Déploiement Terraform + Ansible..."

  cd terraform
  terraform init -input=false
  terraform apply -auto-approve

  echo "🌐 Récupération des adresses IP..."
  PROMETHEUS_IP=$(terraform output -raw prometheus_ip)
  ROCKETCHAT_IP=$(terraform output -raw rocketchat_ip)
#  echo "🌐 Récupération des noms DNS..."
#  PROMETHEUS_DNS=$(terraform output -raw supervision_dns)
#  ROCKETCHAT_DNS=$(terraform output -raw rocketchat_dns)

  cd ..

  echo "📄 Génération de l'inventaire Ansible..."
  cat > ansible/inventory.ini <<EOF
[monitoring]
$PROMETHEUS_IP ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa_azure ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

[rocketchat]
$ROCKETCHAT_IP ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa_azure ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOF

  echo "🚀 Lancement du playbook Ansible de déploiement Prometheus, Grafana et Rocketchat..."
  cd ansible
  ansible-playbook -i inventory.ini install-monitoring.yml --ask-vault-pass -v
  echo "🚀 Lancement du playbook Ansible de configuration Rocketchat..."
  ansible-playbook rocketchat_auth.yml --ask-vault-pass -v

elif [[ "$ACTION" == "destroy" ]]; then
  echo "🔥 Destruction contrôlée de l'infrastructure (hors IPs publiques)..."

  cd terraform
  terraform destroy -target=module.vm -auto-approve
  terraform destroy -target=module.network.azurerm_subnet.subnet -auto-approve

  echo "✅ Destruction terminée. Les IP publiques sont toujours présentes."

else
  echo "❌ Usage : $0 [deploy|destroy]"
  exit 1
fi
