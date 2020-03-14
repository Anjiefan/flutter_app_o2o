class ShopType {
  int id;
  int status;
  String name;
  String img;
  String disc;
  String date;
  String updateDate;
  int fatherType;

  ShopType(
      {this.id,
        this.status,
        this.name,
        this.img,
        this.disc,
        this.date,
        this.updateDate,
        this.fatherType});

  ShopType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    img = json['img'];
    disc = json['disc'];
    date = json['date'];
    updateDate = json['update_date'];
    fatherType = json['father_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['img'] = this.img;
    data['disc'] = this.disc;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['father_type'] = this.fatherType;
    return data;
  }
}
