class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  ProductRating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'].toDouble(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: ProductRating.fromJson(json['rating']));
  }
}

class ProductRating {
  double rate;
  int count;

  ProductRating({required this.rate, required this.count});

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(rate: json['rate'].toDouble, count: json['count']);
  }
}
