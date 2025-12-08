import boto3
import json

def main():
    region = "us-east-1"
    lambda_client = boto3.client("lambda", region_name=region)

    function_name = "s3lambda698-s3-logger"  

    payload = {"message": "Invoked from Boto3"}

    print(f"Invoking Lambda: {function_name}")
    response = lambda_client.invoke(
        FunctionName=function_name,
        InvocationType="RequestResponse",
        Payload=json.dumps(payload),
    )

    
    response_payload = response["Payload"].read().decode("utf-8")
    print("Lambda response payload:")
    print(response_payload)

if __name__ == "__main__":
    main()
