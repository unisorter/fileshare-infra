const AWS = require('aws-sdk')
const s3 = new AWS.S3()

exports.handler = async function(event, context) {
    console.log("EVENT: \n" + JSON.stringify(event, null, 2));
    console.log("EVENT: \n" + JSON.stringify(context, null, 2));
    let bucket = process.env.S3_BUCKET
    var params = {
        Bucket: bucket,
        Fields: {
          key: 'key.png'
        }
      };
    var presignedPost = s3.createPresignedPost(params, function(err, data) {
        if (err) {
          console.error('Presigning post data encountered an error', err);
          return err;
        } else {
          console.log('The post data is', data);
          return data;
        }
      });

  return presignedPost;
}


