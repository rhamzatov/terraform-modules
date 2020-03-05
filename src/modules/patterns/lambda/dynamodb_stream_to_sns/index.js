const TOPIC_ARN = process.env.TOPIC_ARN

const aws = require("aws-sdk")
const sns = new aws.SNS()

function createCorrelationId() {
  return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(c) {
    const r = (Math.random() * 16) | 0,
      v = c == "x" ? r : (r & 0x3) | 0x8

    return v.toString(16)
  })
}

function createSnsMessage(event) {
  return {
    Message: JSON.stringify(event),
    TopicArn: TOPIC_ARN,
    MessageAttributes: {
      "X-CorrelationId": {
        DataType: "String",
        StringValue: createCorrelationId()
      }
    }
  }
}

exports.handler = function(event, _context, callback) {
  console.log("Batch size is " + event.Records.length)

  try {
    for (let index = 0; index < event.Records.length; ++index) {
      const record = event.Records[index]
      const snsMessage = createSnsMessage(record)

      sns.publish(snsMessage, function(error) {
        if (error) {
          console.log("SNS publish failed due to %s; record size is %s", error, record.dynamodb.SizeBytes)
          throw error
        }
      })
    }

    callback(null, "done")
  } catch (ex) {
    callback(ex, "failed")
  }
}
