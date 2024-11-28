class ApiClient {
  static const String baseUrl = 'http://139.59.65.225:8052';
  static String get loginUrl => '$baseUrl/user/login';
  static String get userProfileUrl => '$baseUrl/user/my-profile';
  static String get createTaskUrl => '$baseUrl/task/create-task';
  static String get getAllTaskUrl => '$baseUrl/task/get-all-task';
  static String get deleteTaskUrl => '$baseUrl/task/delete-task/';
}
