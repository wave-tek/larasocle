#!/bin/bash

# Chemin du dossier où Laravel doit être installé
PROJECT_DIR="./laravel-app"

# Vérifier si le dossier existe déjà
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Laravel n'est pas encore installé. Installation en cours..."
    
    # Installer Laravel
    composer create-project --prefer-dist laravel/laravel $PROJECT_DIR

    echo "Installation de Laravel terminée."
else
    echo "Laravel est déjà installé."
fi

# Vérification de l'argument
if [ -z "$1" ]; then
    echo "Erreur : l'environnement n'a pas été spécifié. Utilisez 'dev' ou 'prod'."
    exit 1
fi

ENV=$1

# Copier le fichier .env correspondant
echo "Configuration pour l'environnement : $ENV"
ENV_DIR="./env/$ENV"

if [ ! -f "$ENV_DIR/.env" ]; then
    echo "Erreur : le fichier .env pour l'environnement '$ENV' est introuvable dans $ENV_DIR."
    exit 1
fi

if [ ! -f ".env" ]; then
    echo "Copie du fichier .env depuis $ENV_DIR vers la racine..."
    cp "$ENV_DIR/.env" ./.env
else
    echo "Le fichier .env existe déjà dans la racine."    
fi

# Copier le fichier .env après l'installation
if [ -f ".env" ]; then
    echo "Copie du fichier .env dans le dossier Laravel..."
    cp .env $PROJECT_DIR/.env
fi

if [ ! -f "$ENV_DIR/docker-compose.yml" ]; then
    echo "Erreur : le fichier docker-compose.yml pour l'environnement '$ENV' est introuvable dans $ENV_DIR."
    exit 1
fi

if [ ! -f "./docker-compose.yml" ]; then
    echo "Copie du fichier docker-compose.yml depuis $ENV_DIR vers la racine..."
    cp "$ENV_DIR/docker-compose.yml" ./docker-compose.yml
else
    echo "Le fichier docker-compose.yml existe déjà dans la racine."    
fi


# Donner les permissions nécessaires au dossier storage et bootstrap/cache
echo "Configuration des permissions..."
chmod -R 755 $PROJECT_DIR
chmod -R 775 $PROJECT_DIR/storage $PROJECT_DIR/bootstrap/cache
echo "Permissions configurées."