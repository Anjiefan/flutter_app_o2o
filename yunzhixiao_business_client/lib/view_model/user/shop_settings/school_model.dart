import 'package:yunzhixiao_business_client/providers/custom/school_view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/school_repository.dart';
class SchoolListModel extends SchoolViewStateRefreshListModel{
  @override
  Future<List> loadData({int pageNum, String search}) async{
    return await SchoolRepository.fetchSchools(pageNum: pageNum, search: search);
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