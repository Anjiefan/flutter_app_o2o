import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';

class CommodityRepository {
  static Future fetchCommodityType(int pageNum) async {
    var response = await http.netFetch('self_commodity_types/',
        params: {
          'page': pageNum == null ? 1 : pageNum,
        },
        method: 'get');
    return CommodityTypeList.fromJson(response.data).data;
  }

  static Future fetchCommodityTypeById(int id) async {
    var response =
        await http.netFetch('self_commodity_types/$id/', method: 'get');
    return CommodityType.fromJson(response.data);
  }

  static Future updateCommodityType(int id, String name) {
    return http.netFetch('self_commodity_types/$id/',
        params: {'name': name}, method: 'put');
  }

  static Future deleteCommodityType(
    int id,
  ) {
    return http.netFetch('self_commodity_types/$id/',
        method: 'put', params: {'is_delete': true});
  }

  static Future deleteCommodity(
    int id,
  ) {
    return http.netFetch('self_commodities/$id/',
        method: 'put', params: {'is_delete': true});
  }

  static Future updateCommodityTypeOrdering(String ids) {
    return http.netFetch('ordering_commodity_type/',
        params: {'ids': ids}, method: 'get');
  }

  static Future createCommodityType(String name) async {
    await http.netFetch('self_commodity_types/',
        params: {"name": name}, method: 'post');
  }

  static Future fetchCommodity(int pageNum, {int type, int status}) async {
    var response = await http.netFetch('self_commodities/',
        params: {
          'page': pageNum == null ? 1 : pageNum,
          'type': type == null ? '' : type,
          'status': status == null ? '' : status
        },
        method: 'get');
    return CommodityList.fromJson(response.data).data;
  }

  static updateCommodityStatus(int id, int status) async {
    await http.netFetch('self_commodities/$id/',
        params: {
          'status': status,
        },
        method: 'put');
  }

  static Future updateCommodityOrdering(String ids) {
    return http.netFetch('ordering_commodity/',
        params: {'ids': ids}, method: 'get');
  }

  static Future fetchCommodityById(int id) async {
    var response =
        await http.netFetch('self_commodities/${id}/', method: 'get');
    return Commodity.fromJson(response.data);
  }

  static updateCommodity(
      String img, String name, double price, int type, int id) async {
    await http.netFetch('self_commodities/$id/',
        params: {'name': name, 'price': price, 'type': type, 'img': img},
        method: 'put');
  }

  static Future createCommodity(
      String img, String name, double price, int type) async {
    await http.netFetch('self_commodities/',
        params: {"name": name, "price": price, "type": type, 'img': img},
        method: 'post');
  }
}
