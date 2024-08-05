class Authmodel {
  String? username;
  String? password;
  String? email;
  String? phone;
  String? name;
  String? sId;
  int? iV;

  Authmodel(
      {this.username,
        this.password,
        this.email,
        this.phone,
        this.name,
        this.sId,
        this.iV});

  Authmodel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;

    return data;
  }
}
