# Provision Node.js App
I choose this Node.js App to provision:<br />
[zowe/sample-node-api: A sample node js api for finding cars and accounts for a dealership](https://github.com/zowe/sample-node-api)

## Testing from Vagrant
If you have Vagrant and VirtualBox, you can test this easily.

For simplicity place your ```aws_accessKeys.csv``` to this repo's root directory. You can download this file when you create your access key or write your existing one to this file in this format:
```
Access key ID,Secret access key
MY_ACCESS_KEY_ID,MY_SECRET_ACCESS_KEY
```

Use ```vagrant up``` command to start a VM and then ```vagrant ssh``` to login the VM via SSH.

### Try Node.js app from Docker
When VM runs first time Node.js app is running.<br />
You can test the container for example with this command:<br />
```curl localhost:18000/accounts```

This will provide json output.

If the container doesn't run, you can start with this command:<br />
```docker run -p 18000:18000 -d sample-node-api```

### AWS provision with Terraform
Vagrant also set your AWS credentials from ```aws_accessKeys.csv```, so you don't need to care about them now.

You can test AWS provision with Terraform from ```/vagrant/terraform``` directory
