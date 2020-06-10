server {
        listen 80;
        listen [::]:80;
        server_name aulavirtual.gonzalonazareno.org;

        location / {
                return 301 https://$host$request_uri;
        }
}
server {
    listen 443 ssl;
    server_name aulavirtual.gonzalonazareno.org;

    ssl_certificate /etc/letsencrypt/live/aulavirtual.gonzalonazareno.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/aulavirtual.gonzalonazareno.org/privkey.pem;


    location ^~ /.well-known/acme-challenge/ {
                alias /var/www/html/default/.well-known/acme-challenge/;
    }

    location / {
        ssi on;
        ssi_types application/x-javascript application/javascript;

        proxy_pass http://127.0.0.1:5000/;

        proxy_redirect off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Host $server_name;
    }

    
}


