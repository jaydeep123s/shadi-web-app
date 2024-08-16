# scripts/deploy.sh
#!/bin/bash

# Print a message indicating the start of the deployment
echo "Starting deployment..."

# Navigate to the application directory or create it if it doesn't exist
if [ ! -d "/home/ubuntu/shadi-web-app" ]; then
    mkdir -p /home/ubuntu/shadi-web-app
fi

cd /home/ubuntu/shadi-web-app

# Pull the latest code from the repository
git pull origin main

# Install dependencies
pip install -r requirements.txt

# Configure Nginx
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

# Restart Nginx to apply the changes
sudo systemctl restart nginx

# Run the application
nohup python3 app/app.py &
