


import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/distribution.dart';

class DataRepository {
  static Future fetchDistributionData() async {
    var response = await http.netFetch('distribution_data/', params: {
    }, method: 'get');

    return Distribution
        .fromJson(response.data);
  }
}