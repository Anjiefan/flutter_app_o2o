import 'package:yunzhixiao_business_client/providers/custom/campus_code_info_view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/providers/custom/school_view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/school_repository.dart';
import 'package:yunzhixiao_business_client/service/wallet_repository.dart';

class CampusCodeInfoListModel extends CampusCodeInfoViewStateRefreshListModel {
  @override
  Future<List> loadData({int pageNum, int year, int month}) async {
    return await WalletRepository.fetchCampusCodeInfoDetail(
        page: pageNum, year: year, month: month);
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
