# AWS Document Translation Workflow

## Overview of the Workflow:

1. **Create Two S3 Buckets:**
   - Create two S3 buckets - one for input documents (e.g., `input-documents-bucket`) and another for the output after translation (e.g., `output-translated-bucket`).

2. **Upload Documents to the Input S3 Bucket:**
   - Upload the documents you want to translate to the `input-documents-bucket`.

3. **Trigger Lambda Function on S3 Upload:**
   - Configure an S3 event trigger on the `input-documents-bucket`. This trigger should invoke the Lambda function whenever a new document is uploaded.

4. **Lambda Function Translation:**
   - Update the Lambda function code to translate the content of each document using the AWS Translate service.

5. **Save Translated Documents to Output S3 Bucket:**
   - The Lambda function now uploads the translated content to the `output-translated-bucket`.

## Step-by-Step Guide:

### Step 1: Create Two S3 Buckets
Create two S3 buckets - `input-documents-bucket` and `output-translated-bucket`.

### Step 2: Upload Documents to the Input S3 Bucket
Upload the documents you want to translate to the `input-documents-bucket`.

### Step 3: Trigger Lambda Function on S3 Upload
Configure an S3 event trigger on the `input-documents-bucket`. This trigger should invoke the Lambda function whenever a new document is uploaded.

### Step 4: Lambda Function Translation
Update the Lambda function code to translate the content of each document to the desired language and save the translated content to the `output-translated-bucket`.

### Step 5: Save Translated Documents to Output S3 Bucket
Ensure that both S3 buckets and the Lambda execution role have the necessary permissions for S3 and Translate services.

## IAM Role Setup:

### Step 1: Create an IAM Role
1. Go to the [AWS Management Console](https://aws.amazon.com/console/).
2. Navigate to the **IAM (Identity and Access Management)** service.
3. In the left navigation pane, choose **Roles**.
4. Click on **Create role**.
5. Choose **AWS service** as the type of trusted entity.
6. For the use case, select **Lambda**.
7. Click **Next: Permissions**.

### Step 2: Attach Policies
1. In the **Search policies** box, search for policies relevant to your use case.
   - AmazonS3FullAccess: Provides full access to S3.
   - TranslateFullAccess: Provides full access to Translate.
2. Select the policies you need and click **Next: Tags**.

### Step 3: Add Tags (Optional)
Add tags if needed, then click **Next: Review**.

### Step 4: Review
1. Provide a meaningful name for the role, e.g., `LambdaS3TranslateRole`.
2. Optionally, provide a description for the role.
3. Click **Create role**.

### Step 5: Attach the IAM Role to Lambda Function
1. In the AWS Lambda console, navigate to your Lambda function.
2. In the **Configuration** tab, scroll down to the **Permissions** section.
3. In the **Execution role**, click on the existing role.
4. In the IAM console, click on the **Attach policies** button.
5. Search and attach the same policies (S3,LambdaExcutionBasicfullacess,AmazonS3FullAccess and TranslateFullAccess).
6. Click **Attach policies**.

