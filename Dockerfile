# Utilise l'image officielle Nginx
FROM nginx:alpine

# Supprime la page d'accueil par défaut
RUN rm -rf /usr/share/nginx/html/*

# Copie tes fichiers dans le dossier Nginx
COPY . /usr/share/nginx/html

# Expose le port 80
EXPOSE 80
