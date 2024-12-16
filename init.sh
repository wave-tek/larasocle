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

# Copier le fichier .env après l'installation
if [ -f ".env" ]; then
    echo "Copie du fichier .env dans le dossier Laravel..."
    cp .env $PROJECT_DIR/.env
fi

# Donner les permissions nécessaires au dossier storage et bootstrap/cache
echo "Configuration des permissions..."
chmod -R 755 $PROJECT_DIR
chmod -R 775 $PROJECT_DIR/storage $PROJECT_DIR/bootstrap/cache
echo "Permissions configurées."