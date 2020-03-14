import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_with_date_filter.dart';
import 'package:yunzhixiao_business_client/service/data_center_repository.dart';

class DailyCommodityModel extends ViewStateRefreshListDateFilterModel {
  @override
  Future<List> loadData({int pageNum}) async {
    return await DataCenterRepository.fetchDailyCommodity(
        year: this.year, month: this.month,day: this.day);
  }

  @override
  initData() {
    return super.initData();
  }
  //ordring= 好评 good_rate  销量 sales
  //0表示降序，1表示正序
  @override
  orderingData({String ordering}){
    if(ordering.startsWith('-')){
      ordering=ordering.replaceFirst('-', '');
      return this.list.sort((left,right)=>right.toJson()[ordering].compareTo(left.toJson()[ordering]));
    }
    else{
      return this.list.sort((left,right)=>left.toJson()[ordering].compareTo(right.toJson()[ordering]));
    }
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}
