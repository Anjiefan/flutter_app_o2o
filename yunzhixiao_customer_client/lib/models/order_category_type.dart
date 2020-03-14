class CategoryType {
  int id;
  String type;
  String commodityStatus;
  bool isOperate;
  String date;
  String updateDate;

  CategoryType(
      {this.id,
        this.type,
        this.commodityStatus,
        this.isOperate,
        this.date,
        this.updateDate});

  CategoryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    commodityStatus = json['commodity_status'];
    isOperate = json['is_operate'];
    date = json['date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['commodity_status'] = this.commodityStatus;
    data['is_operate'] = this.isOperate;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    return data;
  }
}