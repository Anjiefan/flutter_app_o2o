

import 'package:yunzhixiao_customer_client/models/team_father.dart';
import 'package:yunzhixiao_customer_client/models/user_data.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/user_invite_repository.dart';
import 'package:yunzhixiao_customer_client/service/user_repository.dart';

class RedPacketModel extends ViewStateRefreshListModel{
  final int shopId;
  RedPacketModel(this.shopId);
  @override
  Future<List> loadData({int pageNum}) async {
    return await UserRepository.getRedPacket(this.shopId);
  }

}