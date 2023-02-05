class Product {
  String name;
  String description;
  String id;
  String category;
  String company;
  String price;
  String quantity;
  String image1;
  String image2;
  String image3;
  String image4;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.company,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    this.id = '',
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'company': company,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'id': id,
      'price': price,
      'quantity': quantity,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      category: json['category'],
      company: json['company'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      id: json['id'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
