# all: init plan execute
init:
	terraform -chdir="./app" init
plan:
	terraform -chdir="./app" plan
execute:
	echo "executing"
	dir ./app