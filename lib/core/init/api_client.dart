class ApiClient {
  static const String baseUrl = 'http://206.189.138.45:8052';
  static String get loginUrl => '$baseUrl/user/login';
  static String get registrationUrl => '$baseUrl/user/register';
  static String get userProfileUrl => '$baseUrl/user/my-profile';
  static String get createTaskUrl => '$baseUrl/task/create-task';
  static String get getAllTaskUrl => '$baseUrl/task/get-all-task';
  static String get deleteTaskUrl => '$baseUrl/task/delete-task/';
  static String get getSpecificTaskUrl => '$baseUrl/task/get-task/';
  static String get activeUserUrl => '$baseUrl/user/activate-user';
  static String get updateUserUrl => '$baseUrl/user/update-profile';
}
