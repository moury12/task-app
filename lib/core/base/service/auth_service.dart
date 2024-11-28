import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:task_management/core/init/api_client.dart';

class AuthService {
  static Future<Map<String, dynamic>> loginRequest({
    required String email,
    required String password,
  })
  async {
    try {
      final url = Uri.parse(ApiClient.loginUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      final body = jsonEncode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }

  static Future<Map<String, dynamic>> fetchUserProfile({required String token}) async {

    try {
      final url = Uri.parse(ApiClient.userProfileUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        url,
        headers: headers,
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {

        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }
}
