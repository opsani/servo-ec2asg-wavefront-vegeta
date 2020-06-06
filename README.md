# servo-ec2asg-wavefront-vegeta
A combination of connectors for Servo to work with ec2/ASG Wavefront and Vegeta

Launch the ec2 instance with cloud formation

```bash
aws cloudformation create-stack --stack-name servo-ec2asg --template-body file://ec2-docker-python3-amazon-linux-2.cft --parameters ParameterKey=KeyName,ParameterValue={key_name}
```

log into the instance via SSH, the output from the CFT describes the ssh command:

```bash
aws cloudformation describe-stacks --stack-name servo-ec2asg | jq .Stacks[0].Outputs[0].OutputValue | tr -d \"
```
