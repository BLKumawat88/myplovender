import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class APICall {
  // AIzaSyC6yNtdqyNYlin0XHr0QXbKM94grrmWRto
  // static const apiBaseUri = "http://myplovendor.itworkshop.in:6000";
  static const apiBaseUri = "https://myplovendor.itworkshop.in";
  // final apiBaseUri = "https://exam.itworkshop.in/api";

  static Future<dynamic> getRequest(String endPoint, String token) async {
    var apiUrl = Uri.parse(apiBaseUri + endPoint);
    log("$apiBaseUri$endPoint");
    try {
      final apiResponse = await http.get(
        apiUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Xauthorization': "Bearer $token"
        },
      );

      if (apiResponse.statusCode == 200) {
        final finalResponse = json.decode(apiResponse.body);
        print("decode ${json.decode(apiResponse.body)} ");
        return finalResponse;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> postRequest(
      String endPoint, dynamic postData, String token) async {
    var apiUrl = Uri.parse(
      apiBaseUri + endPoint,
    );
    log("$apiBaseUri$endPoint");
    log("Token $token");
    // print(json.encode(postData));
    //encoded Data
    try {
      final apiResponse = await http.post(apiUrl,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Xauthorization': "Bearer $token"
          },
          body: json.encode(postData));
      print("apiResponse $apiResponse");
      print("decode ${json.decode(apiResponse.body)} ");
      if (apiResponse.statusCode == 401) {
        return {"status": 401};
      } else {
        final finalResponse = json.decode(apiResponse.body);
        return finalResponse;
      }
    } catch (error) {
      rethrow;
    }
  }
}
