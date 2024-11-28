import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
  static Future<Map<String, dynamic>> activeUser({
    required String email,
    required String code,
  })
  async {
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
        request.files.add(
          await http.MultipartFile.fromPath(
            'file', // Key as expected by the backend
            file.path,
           // Adjust content type if needed
          ),
        );
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
      {required String token})
  async {
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
    File? file,
    required token
  })async{
    final url = Uri.parse(ApiClient.updateUserUrl);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =http.MultipartRequest('PATCH', url,)
      ..headers.addAll(headers)
      ..fields['firstName']=firstName
      ..fields['lastName']=lastName
      ..fields['address']=address;
   if(file!=null) {
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }
    try{
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);
      if (jsonResponse['status']!= null&&jsonResponse['status']=='Success') {
        return jsonResponse; // Successful response
      } else {
        throw jsonResponse;
      }
    }catch(e){
      debugPrint(e.toString());
    }return{};
  }
}
