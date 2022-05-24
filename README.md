# aws-summit-demo-2022

This is the code used for the demo that was run during the session presented as the AWS Tel Aviv Summit, 2022

CON302 - Increasing developer velocity with Serverless Containers
## Demo walkthrough

1. Clone the demo repo

    ```
    git clone https://github.com/AguzzDev/elementor-landingpage.git
    cd elementor-landingpage
    ```

2. Set environment variable

   - `export AWS_ACCOUNT="1234567890" ##choose your account number`
   - `export AWS_REGION="us-west-2" ##choose your region`

3. Run the demo script to create additional scripts for demo purposes

    `/bin/bash ./demo.sh`

    This will create number of additional files in the folder
    - `Dockerfile`
    - `.dockerignore`
    - `build.sh`
    - `customize.sh`

4. Get the login password for your ECR repo
    `aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com`

5. Run the build script

    `/bin/bash/ ./build.sh`

    This will build a docker image and push the created image to your ECR repository with two tags, one immutable based on a timestamp and the second `latest`

6. Customize the code

    `/bin/bash ./customize.sh`

    This will change the template code to replace `elementor` with `AnyCompany`

