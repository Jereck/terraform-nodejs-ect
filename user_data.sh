#!/bin/bash
# Update packages
yum update -y

# Install Node.js 18.x
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

# Install PM2 globally
npm install -g pm2

# Create app directory
mkdir -p /home/ec2-user/node-app

# Create a sample Node.js app
cat << 'EOT' > /home/ec2-user/node-app/server.js
const http = require('http');
const hostname = '0.0.0.0';
const port = 3000;
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello from Node.js with PM2!');
});
server.listen(port, hostname, () => {
    console.log('Server running at http://' + hostname + ':' + port + '/');
});
EOT

# Set permissions
chown -R ec2-user:ec2-user /home/ec2-user/node-app

# Start app with PM2
su - ec2-user -c "pm2 start /home/ec2-user/node-app/server.js --name node-server"
su - ec2-user -c "pm2 startup systemd -u ec2-user --hp /home/ec2-user"
su - ec2-user -c "pm2 save"
