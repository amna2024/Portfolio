# Creating a Text-to-Speech Converter using AWS Polly and Lambda

## Introduction

In this document, we will walk through the process of creating a simple Text-to-Speech (TTS) converter using AWS Polly and AWS Lambda. This serverless solution will enable you to convert plain text and SSML-formatted text into speech and store the generated audio files in an Amazon S3 bucket.

## Prerequisites

Before you begin, ensure you have the following:

1. **AWS Account:** Create an AWS account if you don't have one already.

## Step 1: Set up AWS Polly
--

1. Open the [AWS Polly Console](https://console.aws.amazon.com/polly/).

2. Choose a region (e.g., `us-east-1`) where Polly is available.

   
## Step 2: Set up an IAM Role

1. Open the [IAM Console](https://console.aws.amazon.com/iam/).

2. Navigate to **Roles** and click **Create Role**.

3. Select **AWS Lambda** as the service that will use this role.

4. Attach policies:
   - `AWSLambdaBasicExecutionRole` (for basic Lambda execution)
   - `AmazonPollyFullAccess` (for full access to Polly)
   - `AmazonS3FullAccess` (for full access)
     
## Step 3: Set up an S3 Bucket
--

1. Open the [Amazon S3 Console](https://console.aws.amazon.com/s3/).

2. Create a new S3 bucket (e.g., `mypolly-aws`) to store the generated audio files.

## Step 4: Set up AWS Lambda
----
----
1. Open the [AWS Lambda Console](https://console.aws.amazon.com/lambda/).

2. Create a new Lambda function:
   --------
   - Choose `Author from scratch`.
   - Set the runtime to `Python 3.8`.
   - Set the execution role with the necessary permissions (e.g., Polly and S3 access).

4. In the Lambda function configuration:
   ----
   - Increase the timeout (e.g., 10 seconds) to allow time for audio synthesis.

5. Add the code for your Lambda function:
   ----

   ```python
  import json
from boto3 import Session

def generateAudioUsingText(plainText,filename):
    # Generate audio using Text
    session = Session(region_name="eu-west-1")
    polly = session.client("polly")
    response = polly.synthesize_speech( Text=plainText,
                                        TextType = "text",
                                        OutputFormat="mp3",
                                        VoiceId="Matthew")
    s3 = session.resource('s3')
    bucket_name = "mypolly-aws"
    bucket = s3.Bucket(bucket_name)
    filename = "video-001100/" + filename
    stream = response["AudioStream"]
    bucket.put_object(Key=filename, Body=stream.read())
    
    
def generateAudioUsingSSML(ssmlText,filename):
    # Generate audio using Text
    session = Session(region_name="us-east-1")
    polly = session.client("polly")
    response = polly.synthesize_speech( Text=ssmlText,
                                        TextType = "ssml",
                                        OutputFormat="mp3",
                                        VoiceId="Matthew")
    s3 = session.resource('s3')
    bucket_name = "mypolly-aws"
    bucket = s3.Bucket(bucket_name)
    filename = "video-001100/" + filename
    stream = response["AudioStream"]
    bucket.put_object(Key=filename, Body=stream.read())


def lambda_handler(event, context):
    context.timeout = 10
    # Generate audio using Text
    generateAudioUsingText('Leave it better than you found it','polly-text-demo.mp3')
    
    # Generate audio using SSML
    generateAudioUsingSSML('<speak>If everyone does a little bit <break time="800ms"/> it adds up to alot</speak>','polly-ssml-demo.mp3')
    
    return {
        'statusCode': 200,
        'body': json.dumps('Successful Generation of Audio File(s) using AWS Polly')
    }
    ```
  |  Replace "your-region" with the AWS region you are using.

Save and deploy the Lambda function.

Step 5: Test the Text-to-Speech Converter
--
In the Lambda function console, test your function. Verify that the audio files are generated and stored in the S3 bucket.

Download and play the generated audio files to ensure the speech synthesis is working as expected.

Conclusion
--
Congratulations! You have successfully created a Text-to-Speech converter using AWS Polly and Lambda. This serverless solution allows you to convert both plain text and SSML-formatted text into speech, providing a flexible and scalable way to generate audio files. Feel free to extend and customize the solution based on your specific use case.



