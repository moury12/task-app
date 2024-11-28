import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/core/base/model/task_model.dart';
import 'package:task_management/core/init/api_client.dart';

class TaskService {
  static Future<Map<String, dynamic>> createTask({
    required String title,
    required String description,
    required String token,
  }) async {
    try {
      final url = Uri.parse(ApiClient.createTaskUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final body = jsonEncode({'title': title, 'password': description});
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
  static Future<Map<String, dynamic>> deleteTask({

    required String taskId,
    required String token,
  }) async {
    try {
      final url = Uri.parse('${ApiClient.deleteTaskUrl}$taskId');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await http.delete(url, headers: headers,);
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

  static Future<List<TaskModel>> getAllTask({
    required String token,
  }) async {
    List<TaskModel> taskList = [];
    try {
      final url = Uri.parse(ApiClient.getAllTaskUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        url,
        headers: headers,
      );
      final responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        responseData['data']['myTasks'].forEach((com) {
          taskList.add(TaskModel.fromJson(com));
        });
        return taskList;
      } else {
        return taskList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return taskList;
  }
}
