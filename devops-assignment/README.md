# DevOps Assessment

## Implementation Details
Task 1: EC2 provisioning using one input variable, with deletion protection for a production instance.   
Task 2: Remote Terraform state using S3 and DynamoDB locking.   
Task 3: IAM users, groups, roles, and cross-account access.  
Task 4: Least-privilege IAM policy for CI/CD operations.  
Task 5: Fixes for IAM trust policy and overly permissive S3 access.   

## Before Running  
Configure AWS CLI profiles for the required accounts. Never commit credentials.  
Run terraform fmt -recursive, terraform init, terraform validate, and terraform plan before applying.  
Review the plan carefully. AWS resources may incur charges; destroy resources post validation.

## Additional Notes  
Task 1: All five instances use one input variable. prod-db-01 has prevent_destroy in a separate resource block because lifecycle settings must be static.  
Task 2: Create the S3 bucket and DynamoDB table before initializing the remote backend.  
Task 3: No passwords or access keys are stored in the repository. Configure credentials securely when required.   
Task 4: The custom IAM policy follows least privilege instead of granting administrator access.  
Task 5: The trust policy uses the correct IAM role ARN, and S3 permissions are scoped to the required bucket and objects.  
