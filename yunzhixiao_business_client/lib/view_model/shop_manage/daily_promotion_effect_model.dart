import 'package:yunzhixiao_business_client/models/daily_business.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_with_date_filter.dart';
import 'package:yunzhixiao_business_client/service/data_center_repository.dart';

class DailyPromotionEffectModel extends ViewStateRefreshListDateFilterModel {

  @override
  Future<List> loadData({int pageNum}) async {
    return await DataCenterRepository.fetchDailyPromotionEffect(
        year: this.year, month: this.month,day: this.day);
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
