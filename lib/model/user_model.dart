class CustomUser {
  final String signInType; // 'google' or 'guest'
  final Map<String, dynamic>? apiData; // Data returned from your API
  final Map<String, dynamic>? googleData; // Google user data

  CustomUser({
    required this.signInType,
    this.apiData,
    this.googleData,
  });
}
