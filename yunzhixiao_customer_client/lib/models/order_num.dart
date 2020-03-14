class OrderNum {
  int waitPay;
  int waitReceive;
  int waitCancel;

  OrderNum({this.waitPay, this.waitReceive, this.waitCancel});

  OrderNum.fromJson(Map<String, dynamic> json) {
    waitPay = json['wait_pay'];
    waitReceive = json['wait_receive'];
    waitCancel = json['wait_cancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wait_pay'] = this.waitPay;
    data['wait_receive'] = this.waitReceive;
    data['wait_cancel'] = this.waitCancel;
    return data;
  }
}