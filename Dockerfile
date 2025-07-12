# Utilise l'image officielle Nginx
FROM nginx:alpine

# Supprime la page par défaut
RUN rm -rf /usr/share/nginx/html/*

# Copie tes fichiers HTML/CSS dans le dossier servi par Nginx
COPY gadgetsphere-website/ /usr/share/nginx/html

EXPOSE 80
