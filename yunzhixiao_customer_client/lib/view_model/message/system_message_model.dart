import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/system_repository.dart';

class SystemMessageListModel extends ViewStateRefreshListModel{
  SystemMessageListModel();
  @override
  Future<List> loadData({int pageNum}) async{
    return await SystemRepository.fetchSystemMessages(pageNum);
  }
  @override
  initData() {
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}