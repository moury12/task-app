import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/core/init/api_client.dart';
import 'package:task_management/core/utils/helper_function.dart';

class AuthService {
  static Future<String> loginRequest({
    required String email,
    required String password,
  }) async {
    String token = '';
    try {
      final url = Uri.parse(ApiClient.loginUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      final body = jsonEncode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        token = responseData['data']['token'];
        showCustomSnackbar(
            title: responseData['status'],
            message: responseData['message'],
            type: SnackBarType.failed);
        return token;
      } else {
        showCustomSnackbar(
            title: responseData['status'],
            message: responseData['error'],
            type: SnackBarType.failed);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return token;
  }
}
