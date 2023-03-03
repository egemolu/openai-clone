import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchingService {
  final httpClient = http.Client();
  final apiUrl = "http://localhost:4999/";

  Future<String> getAnswer(String prompt) async {
    final Uri restApiUrl = Uri.parse("${apiUrl}generator");
    Map promptData = {'prompt': prompt};
    var body = json.encode(promptData);

    http.Response response = await httpClient.post(restApiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    var data = jsonDecode(response.body)['data'] as String;
    return data;
  }
}
