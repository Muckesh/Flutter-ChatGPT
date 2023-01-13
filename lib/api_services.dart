import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = "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";

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";

  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey",
  };

  static sendMessage(String? message) async {
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: header,
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": "$message",
        "temperature": 0,
        "max_tokens": 200,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": ["Human:", "AI:"],
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var msg = data["choices"][0]['text'];
      return msg;
    } else {
      print("Failed to fetch data");
    }
  }
}
