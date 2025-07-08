#!/bin/bash

set -e

# 1. Appliquer Terraform
echo "🛠️ Lancement de Terraform..."
cd terraform
terraform init -input=false
terraform apply -auto-approve

# 2. Récupérer l'IP publique
echo "🌐 Récupération de l'adresse IP publique..."
PUBLIC_IP=$(terraform output -raw public_ip)
cd ..

# 3. Générer l'inventaire Ansible
echo "📄 Génération de l'inventaire Ansible..."
cat > ansible/inventory.ini <<EOF
[monitoring]
$PUBLIC_IP ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa_azure
EOF

# 4. Lancer Ansible
echo "🚀 Lancement du playbook Ansible..."
cd ansible
ansible-playbook -i inventory.ini install-monitoring.yml -v
