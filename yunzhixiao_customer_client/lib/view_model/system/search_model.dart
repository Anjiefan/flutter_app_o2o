
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_customer_client/commons/constants/config.dart';
import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/models/search_data_list.dart';
import 'package:yunzhixiao_customer_client/models/system_static_info.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_list_model.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_model.dart';
import 'package:yunzhixiao_customer_client/service/system_repository.dart';

class SearchModel extends ViewStateListModel {

  @override
  Future<List> loadData() async {
    // TODO: implement loadData
    return await SystemRepository.getSearchInfo();
  }
  search(key){
    SystemRepository.createSearch(key);
  }
  SearchModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }

  }
}