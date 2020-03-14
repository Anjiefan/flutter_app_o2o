

import 'package:yunzhixiao_customer_client/models/team_father.dart';
import 'package:yunzhixiao_customer_client/models/user_data.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/user_invite_repository.dart';

class UserInviteModel extends ViewStateRefreshListModel{
  String type;
  TeamFather fatherData;
  UserInviteModel({this.type});
  @override
  Future<List> loadData({int pageNum}) async {
    // TODO: implement loadData
    fatherData=await UserInviteRepository.getFatherInviteAndInviteNum();
    return await UserInviteRepository.getChildInvite(pageNum,type: type);
  }

}