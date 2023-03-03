const express = require("express");
require("dotenv").config();

const { Configuration, OpenAIApi } = require("openai");

const app = express();
app.use(express.json());
const port = process.env.PORT || 4999;

const configuration = new Configuration({
  apiKey: process.env.OPEN_AI_KEY,
  //apiKey: "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",
});

const openai = new OpenAIApi(configuration);

app.post("/generator", async (req, res) => {
  try {
    const prompt = req.body.prompt;

    const response = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: prompt,
      temperature: 0,
      max_tokens: 1000,
    });
    return res.status(200).json({
      success: true,
      data: response.data.choices[0].text,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      error: error.response
        ? error.response.data
        : "There was an issue on the server",
    });
  }
});

app.listen(port, () => console.log("serve running"));
