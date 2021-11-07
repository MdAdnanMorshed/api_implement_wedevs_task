class ApiUrl {
  static String globalUrl = '';
  static String baseUrl = 'https://apptest.dokandemo.com/wp-json/';

  /// Register 01
  static String registerPOSTAPI = baseUrl + 'wp/v2/users/register';

  /// Login 02
  static String loginPOSTAPI = baseUrl + 'jwt-auth/v1/token';

  /// Profile Update 03
  static String profileUpdatePOSTAPI = baseUrl + 'jwt-auth/v1/token';

  /// https://apptest.dokandemo.com/wp-json/wp/v2/users/register
  ///http://apptest.dokandemo.com/wp-json/jwt-auth/v1/token

}
