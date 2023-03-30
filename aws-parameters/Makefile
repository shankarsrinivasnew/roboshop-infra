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

prod-plan: git
	terraform init -backend-config=env-prod/state.tfvars
	terraform plan -var-file=env-prod/prod.tfvars

prod-apply: git
	terraform init -backend-config=env-prod/state.tfvars
	terraform apply -var-file=env-prod/prod.tfvars -auto-approve

prod-destroy: 
	terraform init -backend-config=env-prod/state.tfvars
	terraform destroy -var-file=env-prod/prod.tfvars -auto-approve