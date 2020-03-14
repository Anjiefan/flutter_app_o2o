class SearchDataList {
  List<SearchData> data;

  SearchDataList({this.data});

  SearchDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SearchData>();
      json['data'].forEach((v) {
        data.add(new SearchData.fromJson(v));
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

class SearchData {
  int id;
  String key;
  int status;
  String date;
  int user;

  SearchData({this.id, this.key, this.status, this.date, this.user});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    status = json['status'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['status'] = this.status;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}