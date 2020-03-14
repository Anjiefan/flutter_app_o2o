


import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/test_repository.dart';
import 'package:yunzhixiao_business_client/service/order_repository.dart';
//TODO 订单model，需要根据业务进行调整
class OrderTypeModel extends ViewStateRefreshListModel{
  String is_operate;
  OrderTypeModel({this.is_operate});
  @override
  Future<List> loadData({int pageNum}) async{
    return await OrderRepository.fetchOrderTypes(pageNum,is_operate: is_operate);
  }
  @override
  initData() {
    // TODO: implement initData
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}