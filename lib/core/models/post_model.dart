import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 20)
@JsonSerializable()
class Post {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String caption;
  @HiveField(3)
  final List<PostMedia> media;
  @HiveField(4)
  final PostCategory category;
  @HiveField(5)
  final List<String> tags;
  @HiveField(6)
  final String? location;
  @HiveField(7)
  final PostStatus status;
  @HiveField(8)
  final DateTime createdAt;
  @HiveField(9)
  final DateTime updatedAt;
  @HiveField(10)
  final int likesCount;
  @HiveField(11)
  final int commentsCount;
  @HiveField(12)
  final int sharesCount;
  @HiveField(13)
  final int savesCount;
  @HiveField(14)
  final bool isLiked;
  @HiveField(15)
  final bool isSaved;
  @HiveField(16)
  final String? productId;
  @HiveField(17)
  final PostEngagement engagement;

  const Post({
    required this.id,
    required this.userId,
    required this.caption,
    this.media = const [],
    required this.category,
    this.tags = const [],
    this.location,
    this.status = PostStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.savesCount = 0,
    this.isLiked = false,
    this.isSaved = false,
    this.productId,
    this.engagement = const PostEngagement(),
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? userId,
    String? caption,
    List<PostMedia>? media,
    PostCategory? category,
    List<String>? tags,
    String? location,
    PostStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    int? savesCount,
    bool? isLiked,
    bool? isSaved,
    String? productId,
    PostEngagement? engagement,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      caption: caption ?? this.caption,
      media: media ?? this.media,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      savesCount: savesCount ?? this.savesCount,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      productId: productId ?? this.productId,
      engagement: engagement ?? this.engagement,
    );
  }
}

@HiveType(typeId: 21)
@JsonSerializable()
class PostMedia {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final PostMediaType type;
  @HiveField(2)
  final String url;
  @HiveField(3)
  final String? thumbnailUrl;
  @HiveField(4)
  final double? duration;
  @HiveField(5)
  final int? width;
  @HiveField(6)
  final int? height;
  @HiveField(7)
  final int order;

  const PostMedia({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.duration,
    this.width,
    this.height,
    this.order = 0,
  });

  factory PostMedia.fromJson(Map<String, dynamic> json) => 
      _$PostMediaFromJson(json);
  Map<String, dynamic> toJson() => _$PostMediaToJson(this);
}

@HiveType(typeId: 22)
@JsonSerializable()
class PostEngagement {
  @HiveField(0)
  final double engagementRate;
  @HiveField(1)
  final int viewsCount;
  @HiveField(2)
  final int clicksCount;
  @HiveField(3)
  final Map<String, int> reactionCounts;

  const PostEngagement({
    this.engagementRate = 0.0,
    this.viewsCount = 0,
    this.clicksCount = 0,
    this.reactionCounts = const {},
  });

  factory PostEngagement.fromJson(Map<String, dynamic> json) => 
      _$PostEngagementFromJson(json);
  Map<String, dynamic> toJson() => _$PostEngagementToJson(this);
}

@HiveType(typeId: 23)
@JsonSerializable()
class Comment {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String postId;
  @HiveField(2)
  final String userId;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final String? parentCommentId;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final DateTime updatedAt;
  @HiveField(7)
  final int likesCount;
  @HiveField(8)
  final int repliesCount;
  @HiveField(9)
  final bool isLiked;

  const Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
    this.likesCount = 0,
    this.repliesCount = 0,
    this.isLiked = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@HiveType(typeId: 24)
enum PostCategory {
  @HiveField(0)
  @JsonValue('product_demand')
  productDemand,
  @HiveField(1)
  @JsonValue('bulk_purchase')
  bulkPurchase,
  @HiveField(2)
  @JsonValue('distress_sales')
  distressSales,
  @HiveField(3)
  @JsonValue('heavy_distributors')
  heavyDistributors,
  @HiveField(4)
  @JsonValue('swap_deals')
  swapDeals,
  @HiveField(5)
  @JsonValue('auctions')
  auctions,
  @HiveField(6)
  @JsonValue('general')
  general,
}

@HiveType(typeId: 25)
enum PostMediaType {
  @HiveField(0)
  @JsonValue('image')
  image,
  @HiveField(1)
  @JsonValue('video')
  video,
}

@HiveType(typeId: 26)
enum PostStatus {
  @HiveField(0)
  @JsonValue('active')
  active,
  @HiveField(1)
  @JsonValue('inactive')
  inactive,
  @HiveField(2)
  @JsonValue('deleted')
  deleted,
  @HiveField(3)
  @JsonValue('reported')
  reported,
}