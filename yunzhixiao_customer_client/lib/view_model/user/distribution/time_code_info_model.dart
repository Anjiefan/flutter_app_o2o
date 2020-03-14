import 'package:yunzhixiao_customer_client/providers/custom/campus_code_info_view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/providers/custom/time_code_info_view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';

class TimeCodeInfoListModel extends TimeCodeInfoViewStateRefreshListModel {
  @override
  Future<List> loadData({int pageNum, int year, int month}) async {
    return await WalletRepository.fetchTimeCodeInfoDetail(
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
