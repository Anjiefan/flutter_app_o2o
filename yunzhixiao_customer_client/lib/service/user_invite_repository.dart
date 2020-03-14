import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/team_father.dart';
import 'package:yunzhixiao_customer_client/models/team_invite.dart';

class UserInviteRepository {
  static Future getFatherInviteAndInviteNum() async {
    var response =
    await http.netFetch('team_users/');
    return TeamFather.fromJson(response.data);
  }
  static Future getChildInvite(int page,{type}) async {
    var response =
    await http.netFetch('team_invited/');
    return TeamInviteList.fromJson(response.data).data;
  }


}
