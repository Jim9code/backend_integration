import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class User {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  final String? profilePicture;
  @HiveField(4)
  final String? bio;
  @HiveField(5)
  final String? location;
  @HiveField(6)
  final String? phoneNumber;
  @HiveField(7)
  final UserRole role;
  @HiveField(8)
  final DateTime createdAt;
  @HiveField(9)
  final DateTime updatedAt;
  @HiveField(10)
  final int followersCount;
  @HiveField(11)
  final int followingCount;
  @HiveField(12)
  final int postsCount;
  @HiveField(13)
  final bool isVerified;
  @HiveField(14)
  final bool isActive;
  @HiveField(15)
  final SellerProfile? sellerProfile;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.profilePicture,
    this.bio,
    this.location,
    this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.isVerified = false,
    this.isActive = true,
    this.sellerProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? profilePicture,
    String? bio,
    String? location,
    String? phoneNumber,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isVerified,
    bool? isActive,
    SellerProfile? sellerProfile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      sellerProfile: sellerProfile ?? this.sellerProfile,
    );
  }
}

@HiveType(typeId: 1)
@JsonSerializable()
class SellerProfile {
  @HiveField(0)
  final String businessName;
  @HiveField(1)
  final BusinessCategory businessCategory;
  @HiveField(2)
  final String businessLocation;
  @HiveField(3)
  final String businessPhone;
  @HiveField(4)
  final String businessEmail;
  @HiveField(5)
  final String? businessDescription;
  @HiveField(6)
  final String? businessWebsite;
  @HiveField(7)
  final List<String> businessDocuments;
  @HiveField(8)
  final String personalId;
  @HiveField(9)
  final SellerStatus status;
  @HiveField(10)
  final DateTime? approvedAt;
  @HiveField(11)
  final String? rejectionReason;
  @HiveField(12)
  final SubscriptionPlan? currentPlan;
  @HiveField(13)
  final DateTime? planExpiresAt;
  @HiveField(14)
  final SellerAnalytics analytics;

  const SellerProfile({
    required this.businessName,
    required this.businessCategory,
    required this.businessLocation,
    required this.businessPhone,
    required this.businessEmail,
    this.businessDescription,
    this.businessWebsite,
    this.businessDocuments = const [],
    required this.personalId,
    this.status = SellerStatus.pending,
    this.approvedAt,
    this.rejectionReason,
    this.currentPlan,
    this.planExpiresAt,
    this.analytics = const SellerAnalytics(),
  });

  factory SellerProfile.fromJson(Map<String, dynamic> json) => 
      _$SellerProfileFromJson(json);
  Map<String, dynamic> toJson() => _$SellerProfileToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class SellerAnalytics {
  @HiveField(0)
  final int totalViews;
  @HiveField(1)
  final int totalLikes;
  @HiveField(2)
  final int totalSales;
  @HiveField(3)
  final double totalRevenue;
  @HiveField(4)
  final int productsCount;
  @HiveField(5)
  final double engagementRate;

  const SellerAnalytics({
    this.totalViews = 0,
    this.totalLikes = 0,
    this.totalSales = 0,
    this.totalRevenue = 0.0,
    this.productsCount = 0,
    this.engagementRate = 0.0,
  });

  factory SellerAnalytics.fromJson(Map<String, dynamic> json) => 
      _$SellerAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$SellerAnalyticsToJson(this);
}

@HiveType(typeId: 3)
enum UserRole {
  @HiveField(0)
  @JsonValue('buyer')
  buyer,
  @HiveField(1)
  @JsonValue('seller')
  seller,
  @HiveField(2)
  @JsonValue('admin')
  admin,
}

@HiveType(typeId: 4)
enum BusinessCategory {
  @HiveField(0)
  @JsonValue('retailer')
  retailer,
  @HiveField(1)
  @JsonValue('wholesaler')
  wholesaler,
  @HiveField(2)
  @JsonValue('manufacturer')
  manufacturer,
  @HiveField(3)
  @JsonValue('distributor')
  distributor,
}

@HiveType(typeId: 5)
enum SellerStatus {
  @HiveField(0)
  @JsonValue('pending')
  pending,
  @HiveField(1)
  @JsonValue('approved')
  approved,
  @HiveField(2)
  @JsonValue('rejected')
  rejected,
  @HiveField(3)
  @JsonValue('suspended')
  suspended,
}

@HiveType(typeId: 6)
enum SubscriptionPlan {
  @HiveField(0)
  @JsonValue('basic')
  basic,
  @HiveField(1)
  @JsonValue('premium')
  premium,
  @HiveField(2)
  @JsonValue('enterprise')
  enterprise,
}