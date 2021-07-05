const AWS = require('aws-sdk')
const s3 = new AWS.S3()

exports.handler = async function(event, context) {
  console.log("EVENT: \n" + JSON.stringify(event, null, 2));
  console.log("EVENT: \n" + JSON.stringify(context, null, 2));
  let bucket = process.env.S3_BUCKET
  var params = {Bucket: bucket, Key: 'key.png', ContentType: 'image/png',};
  return s3.getSignedUrl('putObject', params);
}
