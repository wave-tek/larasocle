#!/bin/bash

# Exécuter le script init.sh sur l'hôte
echo "Exécution du script init.sh..."
bash ./init.sh

# Attendre quelques secondes pour s'assurer que les conteneurs sont démarrés
sleep 5

# Démarrer Docker Compose
echo "Démarrage des conteneurs Docker..."
docker compose down
docker compose up -d

docker exec -it larasocle_node npm install
docker exec -it larasocle_node npm run dev