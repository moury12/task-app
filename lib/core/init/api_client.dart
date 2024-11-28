class ApiClient {
  static const String baseUrl = 'http://139.59.65.225:8052';
  static String get loginUrl => '$baseUrl/user/login';
  static String get userProfileUrl => '$baseUrl/user/my-profile';
}
