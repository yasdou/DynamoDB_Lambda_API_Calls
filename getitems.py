import json
import urllib.request
import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):
    url_base = "https://rickandmortyapi.com/api/character/?page="
    formatted_data = {
        "my-table-rickandmorty": []
    }
    for i in range(1, 4):
        url = url_base + str(i)
        print(url)
        response = urllib.request.urlopen(url)
        data = json.loads(response.read().decode())
        for character in data["results"]:
            item = {
                "Item": {
                    "Id": character["id"],
                    "Name": character["name"],
                    "Status": character["status"],
                    "Species": character["species"],
                }
            }
            formatted_data["my-table-rickandmorty"].append(item)

    # Convert the formatted data to JSON
    json_data = json.dumps(formatted_data)

    # Upload the JSON data to the S3 bucket
    s3.put_object(Bucket="rickandmortymortyandrick", Key="rickandmorty_characters.json", Body=json_data)
    print("Success!")