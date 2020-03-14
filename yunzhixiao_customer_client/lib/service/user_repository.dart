import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/red_packet_list.dart';
import 'package:yunzhixiao_customer_client/models/user.dart';

class UserRepository {
  static Future loginUsernamePassword(String username, String password) async {
    var response =
        await http.post('login/', data: {
          "username": username,
          "password": password
        });
    return response.data.data["token"];
  }

  static Future changePassword(int id, String password, String code) async {
    var response =
    await http.netFetch('users/$id/', params: {
      "code": code,
      "password": password
    }, method: 'put');
    return response.data;
  }

  static Future register(String username, String password, String code) async {
    var response =
    await http.netFetch('users/', params: {
      "code": code,
      "username": username,
      "password": password
    }, method: 'post');
    return response.data;
  }

  static Future loginUsernameCode(String username, String code) async {
    var response =
        await http.get('login_with_code/', queryParameters: {
          "username": username,
          "code": code
        });
    return response.data.data["token"];
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

  static Future updatePushInfo(int platform, String deviceToken, int endType) async {
    var response = await http.post('push_info/', data: {
      "platform": platform,
      "device_token": deviceToken,
      "end_type": endType
    });
    return response.data.data;
  }

  static Future getShopQRCode(shopid) async {
    var response =
        await http.netFetch('shop_erweima/', params: {
          'shopid':shopid
        },method: 'get');
    return response.data;
  }

  static Future getRedPacket(int shopId) async {
    Map<String, dynamic> data = {

    };
    if (shopId != null){
      data["shop"] = shopId;
    }
    var response =
    await http.netFetch('red_packet/', method: 'get', params: data);
    return RedPacketList.fromJson(response.data).data;
  }

}
