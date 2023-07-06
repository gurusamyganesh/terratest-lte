# all: init plan execute
init:
	terraform -chdir="./app" init
plan:
	terraform -chdir="./app" plan
test:
	cd ./app/terratest/test && go test -v
