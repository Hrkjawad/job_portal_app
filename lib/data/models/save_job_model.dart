class SavedJobsModel {
  int? id;
  final String email;
  final String title;
  final String brand;
  final String price;

  SavedJobsModel({
    this.id,
    required this.email,
    required this.title,
    required this.brand,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'title': title,
    'brand': brand,
    'price': price,
  };

  factory SavedJobsModel.fromMap(Map<String, dynamic> map) => SavedJobsModel(
    id: map['id'],
    email: map['email'],
    title: map['title'],
    brand: map['brand'],
    price: map['price'],
  );
}