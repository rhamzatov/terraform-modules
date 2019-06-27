exports.handler = async event => {
  console.log("this message contains ERROR!!!");
  console.error("other wrong message");

  return {
    statusCode: 200,
    body: JSON.stringify(event)
  };
};
