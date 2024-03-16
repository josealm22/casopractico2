#!/bin/bash

# Cambia al directorio donde se encuentra este script
cd "$(dirname "$0")"

# Ejecución de playbook para extraer ip y guradarla en ../vm_details.yml

/home/ubuntu/casopractico2/casopractico2/ansible/playbooksPullCreds/ansible-playbook extraerip.yml


# Extraer credenciales de ACR 

/home/ubuntu/casopractico2/casopractico2/ansible/playbooksPullCreds/ansible-playbook pullcredacr.yml

# Genera el archivo de inventario hosts.yml usando yq para leer de vm_details.yml
VM_PUBLIC_IP=$(yq e '.vm_public_ip' ../../vm_details.yml)

cat << EOF > /home/ubuntu/casopractico2/casopractico2/ansible/playbooksDespligues/hosts.yml
all:
  children:
    webservers:
      hosts:
        VMazureCP2:
          ansible_host: $VM_PUBLIC_IP
          ansible_user: cp2user
          ansible_ssh_private_key_file: ~/.ssh/id_rsa
EOF

# Ejecuta el playbook maestro de Ansible
ansible-playbook -i /home/ubuntu/casopractico2/casopractico2/ansible/playbooksDespliegues/hosts.yml /home/ubuntu/casopractico2/casopractico2/ansible/playbooksDespliegues/playbook_maestro.yml
