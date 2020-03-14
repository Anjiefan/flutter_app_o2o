class SchoolList {
  List<SchoolItem> data;

  SchoolList({this.data});

  SchoolList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SchoolItem>();
      json['data'].forEach((v) {
        data.add(new SchoolItem.fromJson(v));
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

class SchoolItem {
  int id;
  String name;
  double longitude;
  double latitude;
  String province;
  String city;
  String district;
  String date;
  String updateDate;

  SchoolItem(
      {this.id,
        this.name,
        this.longitude,
        this.latitude,
        this.province,
        this.city,
        this.district,
        this.date,
        this.updateDate});

  SchoolItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    province = json['province'];
    city = json['city'];
    district = json['district'];
    date = json['date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    return data;
  }
}
