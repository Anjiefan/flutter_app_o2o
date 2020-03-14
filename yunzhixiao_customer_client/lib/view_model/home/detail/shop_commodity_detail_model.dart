
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_customer_client/models/cart_info.dart';
import 'package:yunzhixiao_customer_client/models/commodity.dart';
import 'package:yunzhixiao_customer_client/models/shop_commodity_list.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_list_model.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';

class ShopCommodityTypeListModel extends ViewStateListModel<Types> {
  Types _selectedTypes;
  int lastSelectedTime = DateTime.now().millisecondsSinceEpoch;
  Types get selectedTypes => _selectedTypes;
  final int shopUserId;
  ShopCommodityTypeListModel(this.shopUserId);
  @override
  Future<List<Types>> loadData() async {
    return await ShopRepository.fetchShopCommodityTypeList(this.shopUserId);
  }
  onSelectedTypes(Types selectedTypes){
    lastSelectedTime = DateTime.now().millisecondsSinceEpoch;
    if(this._selectedTypes!=selectedTypes){
      this._selectedTypes = selectedTypes;
      this.notifyListeners();
    }
  }
}


class ShopCommodityInfoListModel extends ViewStateListModel<Commodity> {
  final int shopUserId;
  ShopCommodityInfoListModel(this.shopUserId);

  @override
  Future<List<Commodity>> loadData() async {
    return await ShopRepository.fetchShopCommodityInfoList(this.shopUserId);
  }


}

class ShopCartSelfModel extends ViewStateListModel<CartCommodityCartRelate> {
  final int shopId;
  String totalPrice;
  ShopCartSelfModel(this.shopId);
  @override
  Future<List<CartCommodityCartRelate>> loadData() async {
    CartInfo info = await ShopRepository.fetchCartInfoSelf(shopId);
    totalPrice = info.totalPrice;
    notifyListeners();
    return info.cartCommodityCartRelate;
  }

  updateCartInfoNum(int commodityId, int quantityDiffer) async {
    await ShopRepository.updateCartItemNum(this.shopId, commodityId, quantityDiffer);
    await this.refresh();
  }

  clearCartSelfInfo() async {
    await ShopRepository.clearCartInfo(shopId: shopId);
    await this.refresh();
  }

}

class ShopCartListModel extends ViewStateListModel<CartInfo> {
  @override
  Future<List<CartInfo>> loadData() async {
    List<CartInfo> infoList = await ShopRepository.fetchCartInfoList();
    return infoList;
  }

  clearCartListInfo({int shopId}) async {
    await ShopRepository.clearCartInfo(shopId: shopId);
    this.refresh();
  }
}