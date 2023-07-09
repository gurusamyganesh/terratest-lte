# all: init plan execute
init:
	terraform -chdir="./app" init
plan:
	terraform -chdir="./app" plan
test:
	cd ./app/terratest/test && go test -v
apply:
	terraform -chdir="./app" apply -auto-approve
destroy:
	terraform -chdir="./app" destroy -auto-approve	
