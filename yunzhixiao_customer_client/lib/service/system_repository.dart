import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/search_data_list.dart';
import 'package:yunzhixiao_customer_client/models/system_message_list.dart';
import 'package:yunzhixiao_customer_client/models/system_static_info.dart';

class SystemRepository {
  static Future getStaticInfo() async {
    var response = await http.netFetch('user_client_static/', method: 'get');
    return SystemStaticInfo.fromJson(response.data);
  }

  static Future getSearchInfo() async {
    var response = await http.netFetch('user_search/', method: 'get');
    return SearchDataList.fromJson(response.data).data;
  }

  static Future createSearch(key) async {
    var response = await http
        .netFetch('user_search/', method: 'post', params: {'key': key});
  }

  static Future fetchSystemMessages(int pageNum) async {
    var response = await http.netFetch('system_message/',
        params: {
          'page': pageNum == null ? 1 : pageNum,
        },
        method: 'get');
    return SystemMessageList.fromJson(response.data).data.data;
  }

  static Future fetchSystemMessageNum() async {
    var response = await http.netFetch('system_message/num/', method: 'get');
    return SystemMessageNum.fromJson(response.data).data;
  }
}
