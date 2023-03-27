git:
	# git pull
	rm -rvf .terraform
dev-plan: git
	terraform init -backend-config=env-dev/state.tfvars
	terraform plan -var-file=env-dev/dev.tfvars

dev-apply: git
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -var-file=env-dev/dev.tfvars -auto-approve

dev-destroy: 
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -var-file=env-dev/dev.tfvars -auto-approve