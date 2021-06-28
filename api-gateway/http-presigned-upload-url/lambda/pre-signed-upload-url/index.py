import json
import logging
import boto3
import os


def lambda_handler(event, context):
    object_key = event["queryStringParameters"]['key']
    expires_in = event["queryStringParameters"]['expiry']
    s3_client = boto3.client('s3')
    logger = logging.getLogger('fileshare-infra-presigned-url')

    try:
        url = s3_client.generate_presigned_url(
            ClientMethod='put_object',
            Params={'Bucket': os.environ['S3_BUCKET'] , 'Key': object_key },
            ExpiresIn=expires_in
        )
        logger.info("Got presigned URL: %s", url)
    except:
        logger.exception("Couldn't get a presigned URL")
    
    return {
        'statusCode': 200,
        'headers': {
            'x-aws_request_id': context.aws_request_id, 'Content-Type': 'application/json'
        },
        'body': json.dumps({'url': url, 'key': object_key}),
        'isBase64Encoded': False
    };
