import boto3
import json

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('my-table-rickandmorty')

def lambda_handler(event, context):
    # Get the bucket name and JSON file name from the event object
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    json_file_name = event['Records'][0]['s3']['object']['key']

    # Get the JSON file from S3
    s3_object = s3.get_object(Bucket=bucket_name, Key=json_file_name)
    s3_data = s3_object['Body'].read().decode('utf-8')
    json_data = json.loads(s3_data)

    # Write the data to DynamoDB
    with table.batch_writer() as batch:
        for item in json_data['my-table-rickandmorty']:
            batch.put_item(Item=item['Item'])

    return {
        'statusCode': 200,
        'body': json.dumps('Successfully added items to DynamoDB')
    }
