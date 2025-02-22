class ProductCartModel {
  String? id;
  String? title;
  num? price;
  String? description;
  String? image;
  int? quantity;

  ProductCartModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.image,
        this.quantity});

  ProductCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.quantity;
    data['image'] = this.image;

    return data;
  }
}

