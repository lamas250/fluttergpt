import * as logger from "firebase-functions/logger";
// import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import OpenAI from "openai";

const openai = new OpenAI({
  apiKey: functions.config().openai.api_key,
});


exports.checkHealth = functions.https.onCall(async (_data, _context) => {
  logger.info("Checking health");
  return {
    status: "OK",
  };
});

exports.chatWithOpenAI = functions.https.onCall(async (data, context) => {
  logger.info("Chatting with OpenAI");
  const prompt = data.prompt;

  if (!prompt) {
    throw new functions.https.HttpsError("invalid-argument", "Prompt is required");
  }
  try {
    const response = await openai.chat.completions.create({
      model: "gpt-3.5-turbo",
      messages: [{
        role: "user",
        content: prompt,
      }],
    });
    logger.info("OpenAI response", response.choices[0].message?.content);
    return response.choices[0].message?.content;
  } catch (error) {
    logger.error("Error chatting with OpenAI", error);
    throw new functions.https.HttpsError("internal", "Error chatting with OpenAI");
  }
});
