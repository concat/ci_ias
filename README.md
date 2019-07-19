# ci_ias
A Terraform implementation of an entire blue/green web archtitecture. 

The code will build out the entire infrastructure needed to have a blue/green architectural pattern for deploying code.

The actual environment selected is done via the ansible command which is triggered on each instance in the selected ASG via an "ansible pull" request which itself is invoked via another ansible command sent from an ansible control host, in this case performed fron an ansible-enabled instance in the developement environment.See https://github.com/concat/ansible_asg.git and sample apps for deployment at https://github.com/concat/[uvw,xyz].git
