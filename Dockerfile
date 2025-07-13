# Utilise l'image officielle Nginx
FROM nginx:alpine

# Supprime la page par défaut
RUN rm -rf /usr/share/nginx/html/*

# Copie tes fichiers HTML/CSS dans le dossier servi par Nginx
COPY gadgetsphere-website/ /usr/share/nginx/html

# Commande exécutée au démarrage : écrit le hostname dans /usr/share/nginx/html/hostname
CMD sh -c "hostname > /usr/share/nginx/html/hostname && nginx -g 'daemon off;'"

EXPOSE 80
