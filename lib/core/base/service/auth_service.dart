import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
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

  static Future<Map<String, dynamic>> activeUser({
    required String email,
    required String code,
  }) async {
    try {
      final url = Uri.parse(ApiClient.activeUserUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      final body = jsonEncode({'email': email, 'code': code});
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

  static Future<Map<String, dynamic>> registrationRequest({
    required Map<String, dynamic> body,
    File? file,
  })
  async {
    try {
      final url = Uri.parse(ApiClient.registrationUrl);

      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Accept': 'application/json',
      });

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (file != null) {
        if (await file.exists()) {

          final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
          final mimeSplit = mimeType.split('/');

          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
              contentType: MediaType(mimeSplit[0], mimeSplit[1]),
            ),
          );
        } else {
          debugPrint('File does not exist');
        }
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      log(responseData.toString());

      if (response.statusCode == 200 && responseData['status'] == 'Success') {
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return {};
    }
  }

  static Future<Map<String, dynamic>> fetchUserProfile(
      {required String token}) async {
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

  static Future<Map<String, dynamic>> updateProfile({
    required String firstName,
    required String lastName,
    required String address,
    required File? file,
    required String token,
  }) async {
    try {
      final request =
          http.MultipartRequest('PATCH', Uri.parse(ApiClient.updateUserUrl));

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['address'] = address;

      if (file != null && await file.exists()) {
        final mimeType =
            lookupMimeType(file.path) ?? 'application/octet-stream';
        final mimeSplit = mimeType.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
          ),
        );
      } else {
        debugPrint('No file selected or file does not exist.');
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = json.decode(responseData.body);
        debugPrint('Success: ${data['message']}');
        return data;
      } else {
        debugPrint('Failed to update profile: ${response.statusCode}');
        debugPrint('Error details: ${responseData.body}');
      }
    } catch (e) {
      debugPrint('Error during profile update: $e');
    }
    return {};
  }

}
