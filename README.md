# ci_ias
A Terraform implementation of CodeIgniter Multi-Application Framework using AWS Ansible and GIT.

The code will build out the entire infrastructure needed to have a blue/green architectural pattern for deploying code.
The actual environment selected is done via the ansible command which is triggered on each instance via an "ansible pull" request which itself is triggered via another ansible command sent from an ansible control host, in this case performed fron an ansible-enabled instance in the developement environment.
