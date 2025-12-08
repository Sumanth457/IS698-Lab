import boto3
import uuid

def main():
    #region
    region = "us-east-1"

    #S3 client
    s3 = boto3.client("s3", region_name=region)

    #Bucket name
    bucket_name = f"boto3-demo-bucket-{uuid.uuid4().hex[:8]}"

    print(f"Creating bucket: {bucket_name}")

    
    s3.create_bucket(Bucket=bucket_name)

    #simple file in memory
    file_key = "hello.txt"
    file_body = b"Hello from Boto3 S3 demo!"

    print(f"Uploading {file_key} to {bucket_name}")
    s3.put_object(Bucket=bucket_name, Key=file_key, Body=file_body)

    print("Done. You can verify in S3 console.")

if __name__ == "__main__":
    main()
