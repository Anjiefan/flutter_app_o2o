import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/models/order_list.dart';
import 'package:yunzhixiao_business_client/models/school_list.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';

class SchoolRepository {
  static Future fetchSchools({int pageNum, String search}) async {
    var response = await http.netFetch('schools/',
        params: {
          'page': pageNum == null ? 1 : pageNum,
          'search': search == null ? "" : search,
        },
        method: 'get');
    return SchoolList.fromJson(response.data).data;
  }
}
