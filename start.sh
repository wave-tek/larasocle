#!/bin/bash

# Vérification de l'argument
if [ -z "$1" ]; then
    echo "Erreur : vous devez spécifier un environnement (dev ou prod)."
    exit 1
fi

ENV=$1

# Exécuter le script init.sh sur l'hôte 
echo "Exécution du script init.sh pour l'environnement : $ENV ..."
bash ./init.sh "$ENV"

# Attendre quelques secondes pour s'assurer que les conteneurs sont démarrés
sleep 5

# Détection de la commande docker compose ou docker-compose
if command -v docker-compose &> /dev/null; then
    DOCKER_CMD="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_CMD="docker compose"
else
    echo "Erreur : ni 'docker-compose' ni 'docker compose' n'est installé."
    exit 1
fi

echo "Commande Docker détectée : $DOCKER_CMD"

# Démarrer Docker Compose
echo "Démarrage des conteneurs Docker..."
$DOCKER_CMD down
$DOCKER_CMD up -d

# Charger la variable APP_ENV depuis le fichier .env
APP_ENV=$(grep APP_ENV .env | cut -d '=' -f2)
APP_CONTAINERS_PREFIX=$(grep APP_CONTAINERS_PREFIX .env | cut -d '=' -f2)

# Vérifier si la variable APP_ENV est définie
if [ -z "$APP_ENV" ]; then
  echo "APP_ENV non défini dans le fichier .env"
  exit 1
fi

# Vérifier si la variable APP_CONTAINERS_PREFIX est définie
if [ -z "$APP_CONTAINERS_PREFIX" ]; then
  echo "APP_CONTAINERS_PREFIX non défini dans le fichier .env"
  exit 1
fi

echo "APP_ENV détecté : $APP_ENV"
echo "APP_CONTAINERS_PREFIX détecté : $APP_CONTAINERS_PREFIX"

APP_CONTAINER="${APP_CONTAINERS_PREFIX}_app_${APP_ENV}"
NODE_CONTAINER="${APP_CONTAINERS_PREFIX}_node_${APP_ENV}"

# Installer les dépendances de Laravel
echo "Installer les dépendances de Laravel"
docker exec -it $APP_CONTAINER composer install

# Installer les dépendances de Node.js
echo "Installer les dépendances de Node.js"
docker exec -it $NODE_CONTAINER npm install

# Migrer la base de données
echo "Migrer la base de données"
docker exec -it $APP_CONTAINER php artisan migrate

# Lancer le serveur Vite en mode développement
echo "Lancer le serveur Vite en mode développement"
if [ "$ENV" = "dev" ]; then
  docker exec -it $NODE_CONTAINER npm run dev
else
  docker exec -it $NODE_CONTAINER npm run build
fi
