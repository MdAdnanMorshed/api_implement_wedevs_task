import 'package:get/get.dart';
import 'package:task_api_implement/apiurl_link.dart';
import 'package:task_api_implement/bd_helpers/local_store_token.dart';

class RestApiRepository extends GetConnect {
  /// login by @Adnan done
  Future<bool> login(Map<String, dynamic> loginBody) async {
    try {
      final Response response = await post(ApiUrl.loginPOSTAPI, loginBody);
      int code = response.statusCode;
      print('login response code :' + code.toString());
      print('login response res :' + response.bodyString);
      if (code == 200 || code == 201 || code == 202) {
        var token = response.body['token'];
        await LocalStoreToken.object.setToken(token);
        print('token :' + response.body['token']);
        return true;
      }
    } catch (Exception) {
      print('RestApiRepository.login Error Issue :' + Exception);
    }
  }

  /// create account by @Adnan done
  Future<bool> createAccountPostMethod(Map<String, dynamic> bodyMap) async {
    try {
      final Response response = await post(ApiUrl.registerPOSTAPI, bodyMap);
      int code = response.statusCode;
      print('crate register response code :' + code.toString());
      print('create register response res :' + response.bodyString);
      if (code == 200 || code == 201 || code == 202) {
        return true;
      }
    } catch (Exception) {
      print('RestApiRepository.createAccountPostMethod Error :' + Exception);
    }
  }
}
