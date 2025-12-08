import boto3

def main():
    region = "us-east-1"
    ec2 = boto3.client("ec2", region_name=region)

    response = ec2.describe_instances(
        Filters=[{"Name": "instance-state-name", "Values": ["running"]}]
    )

    print("Running EC2 instances:")
    for reservation in response["Reservations"]:
        for inst in reservation["Instances"]:
            instance_id = inst["InstanceId"]
            state = inst["State"]["Name"]
            public_ip = inst.get("PublicIpAddress")
            name_tag = next(
                (t["Value"] for t in inst.get("Tags", []) if t["Key"] == "Name"),
                None,
            )

            print(f"- ID: {instance_id}, State: {state}, Name: {name_tag}, Public IP: {public_ip}")

if __name__ == "__main__":
    main()
