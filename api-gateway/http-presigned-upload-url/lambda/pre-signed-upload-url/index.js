const AWS = require('aws-sdk')
const s3 = new AWS.S3()

exports.handler = async function(event, context) {
  console.log("EVENT: \n" + JSON.stringify(event, null, 2));
  console.log("CONTEXT: \n" + JSON.stringify(context, null, 2));
  var contentType = event.headers['content-type'] !== undefined ? event.headers['content-type'] : 'application/octet-stream';
  var bucket = process.env.S3_BUCKET
  var params = {Bucket: bucket, Key: 'key.png', ContentType: contentType,};
  return s3.getSignedUrl('putObject', params);
}
