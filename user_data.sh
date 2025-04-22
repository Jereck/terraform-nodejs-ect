#!/bin/bash
# Update OS and install Node.js and Git
yum update -y
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

# Install PM2 globally
npm install -g pm2

# Clone the Node.js app from GitHub
cd /home/ec2-user
git clone https://github.com/Jereck/terraform-nodejs-ect.git node-app

# Set ownership
chown -R ec2-user:ec2-user /home/ec2-user/node-app

# Install app dependencies
cd /home/ec2-user/node-app
npm install

# Start the app with PM2
su - ec2-user -c "pm2 start server.js --name node-server"
su - ec2-user -c "pm2 startup systemd -u ec2-user --hp /home/ec2-user"
su - ec2-user -c "pm2 save"
