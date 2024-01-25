Once the CloudFormation template is defined, deploy the stack using the AWS Management Console, AWS CLI, or AWS SDKs. Execute the following command in the AWS CLI:

```bash
aws cloudformation create-stack --stack-name my-web-app-stack --template-body file://stack.yaml
```

To delete the stack:

```bash
aws cloudformation delete-stack --stack-name my-web-app-stack
```