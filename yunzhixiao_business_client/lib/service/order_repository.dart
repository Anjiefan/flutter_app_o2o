import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/models/order_category_type_list.dart';
import 'package:yunzhixiao_business_client/models/order_list.dart';
import 'package:yunzhixiao_business_client/models/order_num.dart';

class OrderRepository{
  static Future fetchOrders(int pageNum,{String ordering,String search
    ,int year,int month
    ,int day,String commodity_status
    ,String service_number, int status}) async {
      Map<String, dynamic> data = {
      'page':pageNum==null?1:pageNum,
      'ordering':ordering==null?'':ordering,
      'search':search==null?'':search,
      'year':year==null?'':year,
      'month':month==null?'':month,
      'day':day==null?'':day,
      'commodity_status':commodity_status==null?'':commodity_status,
      'service_number':service_number==null?'':service_number,
    };
    if (status != null){
      data["status"] = status;
    }
    var response = await http.netFetch('shop_get_orders/',params: data,method: 'get');

    return OrderList.fromJson(response.data).data;
  }

  static Future fetchOrderDetail(id) async {
    var response = await http.netFetch('shop_get_orders/$id',method: 'get');
    return Order.fromJson(response.data);
  }
  static Future fetchBriefOrders(int pageNum,{
    String commodity_status}) async {
    Map<String, dynamic> data = {
      'page':pageNum==null?1:pageNum,
      'commodity_status':commodity_status==null?'':commodity_status,
    };
    var response = await http.netFetch('shop_brief_orders/',params: data,method: 'get');

    return OrderList.fromJson(response.data).data;
  }
  static Future fetchOrderTypes(int pageNum,{String is_operate}) async {
    var response = await http.netFetch('order_category/',params:{
      'page':pageNum==null?1:pageNum,
      'is_operate':is_operate==null?'false':is_operate,
    },method: 'get');

    return CategoryTypeList.fromJson(response.data).data;
//    return [CategoryTypeList.fromJson(response.data).data,CategoryTypeList.fromJson(response.data).data]
  }
  static Future updateOrder(int id,{commodity_status}) async {
    var response =
    await http.put('shop_get_orders/$id/',data: {
      'commodity_status':commodity_status
    });
    return response.data;
  }

    static Future fetchOrderNum() async {
    var response = await http.netFetch('order_num/', method: 'get');
    return OrderNum.fromJson(response.data);
  }
}