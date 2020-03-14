class CommodityTypeList {
  List<CommodityType> data;

  CommodityTypeList({this.data});

  CommodityTypeList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CommodityType>();
      json['data'].forEach((v) {
        data.add(new CommodityType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommodityType {
  int id;
  String name;
  String date;
  String updateDate;
  int shop;
  int user;

  CommodityType({this.id, this.name, this.date, this.updateDate, this.shop, this.user});

  CommodityType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
