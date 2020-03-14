


import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/test_repository.dart';
//TODO 活动model，需要根据业务进行调整
class ActivityListModel extends ViewStateRefreshListModel{
  @override
  Future<List> loadData({int pageNum}) async{
    return await TestRepository.fetchOrders(pageNum);
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}