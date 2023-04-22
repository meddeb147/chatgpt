import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static String apikey = "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";
  static String basedUrl = "https://api.openai.com/v1/completions";

  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": 'Bearer $apikey',
  };

  static Future<String?> sendMessage(String? message) async {
    var res = await http.post(Uri.parse(basedUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          'prompt': '$message',
          'max_tokens': 100,
          'temperature': 0.5,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": ["Human :", "AI"]
        }));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to complete prompt: ${res.statusCode}');
    }
  }
}
