import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/user.dart';
import 'package:yunzhixiao_business_client/models/verification_info.dart';

class UserRepository {

  static Future getVerificationStatus() async {
    var response = await http.netFetch('certification_status/', method: "get");
    return response.data;
  }

  static Future getVerificationInfo() async {
    var response = await http.netFetch('shop_certification/clear/', method: "get");
    return VerificationInfo.fromJson(response.data);
  }

  static Future createVerificationInfo(data) async {
    var response = await http.netFetch('shop_certification/', params: data, method: "post");
    return response.data;
  }

    static Future updateVerificationInfo(id, data) async {
    var response = await http.netFetch('shop_certification/$id/', params: data, method: "put");
    return response.data;
  }

  static Future loginUsernamePassword(String username, String password) async {
    var response =
        await http.get('shop_login/?username=$username&&password=$password');
    return response.data.data;
  }

  static Future changePassword(int id, String password, String code) async {
    var response = await http.netFetch('users/$id/',
        params: {"code": code, "password": password}, method: 'put');
    return response.data;
  }

  static Future register(String username, String password, String code) async {
    var response = await http.netFetch('users/',
        params: {"code": code, "username": username, "password": password},
        method: 'post');
    return response.data;
  }

  static Future loginUsernameCode(String username, String code) async {
    var response =
        await http.get('shop_login_with_code/?username=$username&&code=$code');
    return response.data.data;
  }

  static Future getUserInfo(String username) async {
    var response = await http.get('users/$username/');
    return User.fromJson(response.data.data);
  }

  static Future getCode(String username) async {
    var response = await http.post('codes/', data: {"mobile": username});
    return response.data.data;
  }

  static Future updateUserShopInfo(int shopId, data) async {
    var response = await http.put('shops/$shopId/', data: data);
    return response.data.data;
  }

  static Future getShopQRCode() async {
    var response = await http.netFetch('shop_erweima/', method: 'get');
    return response.data;
  }

  static Future updatePushInfo(
      int platform, String deviceToken, int endType) async {
    var response = await http.post('push_info/', data: {
      "platform": platform,
      "device_token": deviceToken,
      "end_type": endType
    });
    return response.data.data;
  }
}
