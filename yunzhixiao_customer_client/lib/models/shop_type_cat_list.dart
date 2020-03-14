class ShopTypeCatList {
  List<ShopTypeCat> data;

  ShopTypeCatList({this.data});

  ShopTypeCatList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ShopTypeCat>();
      json['data'].forEach((v) {
        data.add(new ShopTypeCat.fromJson(v));
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

class ShopTypeCat {
  int id;
  int categoryType;
  int status;
  String name;
  String img;
  double ordering;
  String disc;
  String date;
  String updateDate;
  int fatherType;

  ShopTypeCat(
      {this.id,
        this.categoryType,
        this.status,
        this.name,
        this.img,
        this.ordering,
        this.disc,
        this.date,
        this.updateDate,
        this.fatherType});

  ShopTypeCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryType = json['category_type'];
    status = json['status'];
    name = json['name'];
    img = json['img'];
    ordering = json['ordering'];
    disc = json['disc'];
    date = json['date'];
    updateDate = json['update_date'];
    fatherType = json['father_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_type'] = this.categoryType;
    data['status'] = this.status;
    data['name'] = this.name;
    data['img'] = this.img;
    data['ordering'] = this.ordering;
    data['disc'] = this.disc;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['father_type'] = this.fatherType;
    return data;
  }
}
