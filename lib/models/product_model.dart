class ProductModel {
  String? id;
  String? name;
  int? price;
  String? item;
  String? image;
  int? iV;

  ProductModel(
      {this.id, this.name, this.price, this.item, this.image, this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    item = json['item'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['item'] = this.item;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}
