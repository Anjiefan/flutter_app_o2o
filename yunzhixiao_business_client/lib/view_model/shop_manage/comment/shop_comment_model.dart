import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/shop_comments_repository.dart';
class ShopCommentListModel extends ViewStateRefreshListModel{
  final isGood;
  ShopCommentListModel({this.isGood});
  @override
  Future<List> loadData({int pageNum}) async{
    return await ShopCommentsRepository.fetchComments(pageNum, isGood);
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