import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';

class EarnCodeInfoListModel extends ViewStateRefreshListModel {
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;

  @override
  Future<List> loadData({int pageNum, int year, int month,int day}) async {
    return await WalletRepository.fetchEarnCodeInfoDetail(
        page: pageNum, year: _year, month: _month,day: _day);
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }

  onRefreshEarnCodeInfo(int year, int month, int day){
    _year = year;
    _month = month;
    _day = day;
    this.refresh();
  }
}
