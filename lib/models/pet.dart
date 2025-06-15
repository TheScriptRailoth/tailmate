import 'package:hive/hive.dart';
part 'pet.g.dart';

@HiveType(typeId: 0)
class Pet extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  int age;

  @HiveField(4)
  int price;

  @HiveField(5)
  bool isAdopted;

  @HiveField(6)
  bool isFavorite;

  @HiveField(7)
  String category;

  Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.price,
    this.isAdopted = false,
    this.isFavorite = false,
    this.category = '',
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json['id'],
    name: json['name'],
    imageUrl: json['imageUrl'],
    age: json['age'],
    price: json['price'],
    isAdopted: json['isAdopted'] ?? false,
    isFavorite: json['isFavorite'] ?? false,
    category: json['category'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'age': age,
    'price': price,
    'isAdopted': isAdopted,
    'isFavorite': isFavorite,
    'category': category,
  };

  Pet copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? age,
    int? price,
    bool? isAdopted,
    bool? isFavorite,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      age: age ?? this.age,
      price: price ?? this.price,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}