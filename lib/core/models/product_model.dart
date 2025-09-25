import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 30)
@JsonSerializable()
class Product {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String sellerId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final String currency;
  @HiveField(6)
  final ProductCategory category;
  @HiveField(7)
  final List<String> images;
  @HiveField(8)
  final List<String> tags;
  @HiveField(9)
  final ProductCondition condition;
  @HiveField(10)
  final int quantity;
  @HiveField(11)
  final String? location;
  @HiveField(12)
  final ProductStatus status;
  @HiveField(13)
  final DateTime createdAt;
  @HiveField(14)
  final DateTime updatedAt;
  @HiveField(15)
  final int viewsCount;
  @HiveField(16)
  final int likesCount;
  @HiveField(17)
  final int savesCount;
  @HiveField(18)
  final double rating;
  @HiveField(19)
  final int reviewsCount;
  @HiveField(20)
  final ARModel? arModel;
  @HiveField(21)
  final ProductDimensions? dimensions;
  @HiveField(22)
  final double? weight;
  @HiveField(23)
  final String? brand;
  @HiveField(24)
  final String? model;
  @HiveField(25)
  final Map<String, dynamic>? specifications;

  const Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.description,
    required this.price,
    this.currency = 'USD',
    required this.category,
    this.images = const [],
    this.tags = const [],
    this.condition = ProductCondition.new_,
    this.quantity = 1,
    this.location,
    this.status = ProductStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.savesCount = 0,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.arModel,
    this.dimensions,
    this.weight,
    this.brand,
    this.model,
    this.specifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? sellerId,
    String? name,
    String? description,
    double? price,
    String? currency,
    ProductCategory? category,
    List<String>? images,
    List<String>? tags,
    ProductCondition? condition,
    int? quantity,
    String? location,
    ProductStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? viewsCount,
    int? likesCount,
    int? savesCount,
    double? rating,
    int? reviewsCount,
    ARModel? arModel,
    ProductDimensions? dimensions,
    double? weight,
    String? brand,
    String? model,
    Map<String, dynamic>? specifications,
  }) {
    return Product(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      savesCount: savesCount ?? this.savesCount,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      arModel: arModel ?? this.arModel,
      dimensions: dimensions ?? this.dimensions,
      weight: weight ?? this.weight,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      specifications: specifications ?? this.specifications,
    );
  }
}

@HiveType(typeId: 31)
@JsonSerializable()
class ARModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fileName;
  @HiveField(2)
  final String fileUrl;
  @HiveField(3)
  final double fileSizeMB;
  @HiveField(4)
  final String? instructions;
  @HiveField(5)
  final DateTime uploadedAt;

  const ARModel({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileSizeMB,
    this.instructions,
    required this.uploadedAt,
  });

  factory ARModel.fromJson(Map<String, dynamic> json) => _$ARModelFromJson(json);
  Map<String, dynamic> toJson() => _$ARModelToJson(this);
}

@HiveType(typeId: 32)
@JsonSerializable()
class ProductDimensions {
  @HiveField(0)
  final double length;
  @HiveField(1)
  final double width;
  @HiveField(2)
  final double height;
  @HiveField(3)
  final String unit;

  const ProductDimensions({
    required this.length,
    required this.width,
    required this.height,
    this.unit = 'cm',
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) => 
      _$ProductDimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDimensionsToJson(this);
}

@HiveType(typeId: 33)
enum ProductCategory {
  @HiveField(0)
  @JsonValue('electronics')
  electronics,
  @HiveField(1)
  @JsonValue('fashion')
  fashion,
  @HiveField(2)
  @JsonValue('home_garden')
  homeGarden,
  @HiveField(3)
  @JsonValue('sports_outdoors')
  sportsOutdoors,
  @HiveField(4)
  @JsonValue('automotive')
  automotive,
  @HiveField(5)
  @JsonValue('books_media')
  booksMedia,
  @HiveField(6)
  @JsonValue('health_beauty')
  healthBeauty,
  @HiveField(7)
  @JsonValue('toys_games')
  toysGames,
  @HiveField(8)
  @JsonValue('food_beverages')
  foodBeverages,
  @HiveField(9)
  @JsonValue('industrial')
  industrial,
  @HiveField(10)
  @JsonValue('other')
  other,
}

@HiveType(typeId: 34)
enum ProductCondition {
  @HiveField(0)
  @JsonValue('new')
  new_,
  @HiveField(1)
  @JsonValue('like_new')
  likeNew,
  @HiveField(2)
  @JsonValue('good')
  good,
  @HiveField(3)
  @JsonValue('fair')
  fair,
  @HiveField(4)
  @JsonValue('poor')
  poor,
}

@HiveType(typeId: 35)
enum ProductStatus {
  @HiveField(0)
  @JsonValue('active')
  active,
  @HiveField(1)
  @JsonValue('inactive')
  inactive,
  @HiveField(2)
  @JsonValue('sold')
  sold,
  @HiveField(3)
  @JsonValue('pending')
  pending,
  @HiveField(4)
  @JsonValue('rejected')
  rejected,
}