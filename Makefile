build:
	docker build -t 127178877223.dkr.ecr.us-east-2.amazonaws.com/toolbox:latest .

push:
	docker push 127178877223.dkr.ecr.us-east-2.amazonaws.com/toolbox:latest
