# CodePipelineProject


## Cloudformation

Cloudformation stack created: *codepipeline-test*, this contains nested stacks for CodePipeline, VPC configuration and ECS Task.

- I created a ne DB subnet group with 2 new private subnets within the default VPC for the RDS instance to limit public access.
- I used Codepipeline for the CI implementation with GitHub webhook from master branch and Codebuild to build the docker image for the python application.
- For testing purpose, I created an ECS Task with Fargate launchtype to test DB connection

From the CFN root stack output, the most important informations can be obtained, such as S3 URL, RDS endpoint, etc. 

## ECS Task

- The Fargate task is launched into a public subnet from the default VPC, this way it is not required to use NAT Gateway or VPC endpoints (which have a hourly fee) to reach public AWS services.
- The fargate task resolves DB credentials from SSM on startup and stores them in environment variables (can be found under /cloudformation/rds/ in SSM)
- Execution logs are stored in CloudWatch Logs in the */ecs/codepipeline-fargate-cluster* Log Group

## Docker application

- I pushed the python:3.8-alpine image to a separate repository to avoid *toomanyrequests:* error when pulling from DockerHub without logging in.
- The build proccess is described in *buildspec.yml* file. The created images are tagged with the commit hash that triggered the pipeline execution.
- The static HTML page is also updated with the commit hash