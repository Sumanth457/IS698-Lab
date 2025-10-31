import boto3
from botocore.exceptions import ClientError
import time
from datetime import datetime, timedelta


dynamodb = boto3.resource('dynamodb', region_name='us-east-1')


# Insert sample data
def insert_sample_data():
    table = dynamodb.Table('hw2-dynamodb')

    now = int(time.time())
    items = [
        {"UserID": "user001", "Timestamp": now - 86400*10, "Name": "Neel", "Email": "neel@xyz.com", "LastLogin": "2025-10-21"},
        {"UserID": "user002", "Timestamp": now - 86400*2, "Name": "Kenny", "Email": "kenny@xyz.com", "LastLogin": "2025-10-29"},
        {"UserID": "user003", "Timestamp": now, "Name": "Sumanth", "Email": "sumanth@xyz.com", "LastLogin": "2025-10-31"}
    ]

    for item in items:
        table.put_item(Item=item)
        print(f"Inserted: {item['UserID']} ({item['Name']})")

# Query users who logged in within the last 7 days
def query_recent_users():
    table = dynamodb.Table('hw2-dynamodb')
    now = int(time.time())
    seven_days_ago = now - (7 * 24 * 60 * 60)

    print("\nUsers logged in within the last 7 days:")
    try:
        response = table.scan(
            FilterExpression="#ts >= :t",
            ExpressionAttributeNames={"#ts": "Timestamp"},
            ExpressionAttributeValues={":t": seven_days_ago}
        )

        items = response.get('Items', [])
        if not items:
            print("No users found in the last 7 days.")
        else:
            for i, item in enumerate(items, 1):
                print(f"\nUser {i}")
                print(f"UserID: {item['UserID']}")
                print(f"Name: {item['Name']}")
                print(f"Email: {item['Email']}")
                print(f"LastLogin: {item['LastLogin']}")
                print(f"Timestamp: {item['Timestamp']}")
    except ClientError as e:
        print("Error scanning table:", e.response['Error']['Message'])

if __name__ == "__main__":
    insert_sample_data()
    query_recent_users()
