## Insights Load Generation / Testing - Terraform-managed EC2

This Terraform code creates an AWS VPC and EC2 instance running Kind, optionally with multiple Insights agents installed in the Kind cluster using the [install-agents script](./../multiple-agents/install-agents.sh). See also the [multiple agents ReadMe for more information about that script](./../multiple-agents/README.md).

Pod-dev members can SSH to the EC2 for troubleshooting or to install additional agents, using their Github username (using the SSH key configured in their Github account).

* Please note that this Terraform code does not use a [Terraform backend](https://www.terraform.io/language/settings/backends) - please protect the generated `terraform.tfstate` file so it can be used to clean up Terraform-managed resources later.

## Using Terraform to Provision An EC2

* Copy this directory, or use your own branch of this repository, as Terraform will create files you will not want to check into the main repository branch.
* Download [Terraform 1.1.8](https://releases.hashicorp.com/terraform/1.1.8/)
* Run `terraform init` to download Terraform providers and modules for the first time. Providers allow Terraform to communicate with AWS, and modules are like packages or libraries of Terraform code.
* Edit the [env.auto.tfvars file](./.env.auto.tfvars) where values are set for [Terraform variables](./inputs.tf). E.G. the IP addresses that should be allowed to SSH to the EC2 instance, and thelist of Github users that will be allowed to SSH.
* Authenticate to an AWS account. E.G. If you [have our Cuddlefish tooling installed](https://fairwinds.slite.com/app/docs/mI~SP~J~B), you can run `cuddlectl use catbox ro-prime`, then switch to the `terraform` sub-directory of this repository.
* Run `terraform plan` - Terraform should show which resources will be created. There may be some syntax warnins, but there should be no errors.
* Run `terraform apply` to create resources.
* After allowing a few minute for the EC2 boot script to run, SSH to the IP address shown at the bottom of the output, where it says `insights_loadtest_public_ip`.
	* You can SSH using your Github username - the SSH key you have configured for your Github account will be accepted. E.G. `ssh ivanfetch-fw@xxx.xxx.xxx.xxx`
	* You can also SSH as the `ubuntu` user, if you specified a value for the `ssh_public_key_filename` Terraform variable.
* Become root by typing `sudo su -` - while this is not best practice, this is how you access the kind cluster and scripts for now.
* You can use `kubectl` and `helm` to access the Kind cluster.
* To view logs from the script that configures the EC2 instance at first boot, see the `/var/log/cloud-init-output.log` file.

### Saving Money / Cleaning Up

When you are done using the EC2 instance, please remember to either:

* Destroy the Terraform-managed resources using the `terraform destroy` command.
* Stop the instance when not in use, to lower AWS billing charges. **Be sure to retain** this copy of the `terraform` directory and accompanying `terraform.tfstate` file so Terraform can be used to destroy the resources it manages.

### Adding More Insights Agents

After SSHing to the EC2, and becoming root by running `sudo su -`, change to the `/insights` directory where you can run the `install-agents.sh` script to install additional agents in the Kind cluster. The `direnv` utility will automatically set environment variables that the `install-agents` script requires - you can see these environment variables in the `/.envrc` file on the EC2. There is also a [description of the environment variables in the multiple agents ReadMe](./../multiple-agents/README.md).

```bash
cd /insights
./install-agents.sh 20
```

See `install-agents.sh -h` for additional script options.
