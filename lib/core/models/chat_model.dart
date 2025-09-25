import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 40)
@JsonSerializable()
class Chat {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<String> participantIds;
  @HiveField(2)
  final String? lastMessageId;
  @HiveField(3)
  final String? lastMessageText;
  @HiveField(4)
  final DateTime? lastMessageAt;
  @HiveField(5)
  final String? lastMessageSenderId;
  @HiveField(6)
  final Map<String, int> unreadCounts;
  @HiveField(7)
  final ChatType type;
  @HiveField(8)
  final String? groupName;
  @HiveField(9)
  final String? groupImage;
  @HiveField(10)
  final DateTime createdAt;
  @HiveField(11)
  final DateTime updatedAt;
  @HiveField(12)
  final bool isActive;
  @HiveField(13)
  final Map<String, dynamic>? metadata;

  const Chat({
    required this.id,
    required this.participantIds,
    this.lastMessageId,
    this.lastMessageText,
    this.lastMessageAt,
    this.lastMessageSenderId,
    this.unreadCounts = const {},
    this.type = ChatType.direct,
    this.groupName,
    this.groupImage,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.metadata,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Chat copyWith({
    String? id,
    List<String>? participantIds,
    String? lastMessageId,
    String? lastMessageText,
    DateTime? lastMessageAt,
    String? lastMessageSenderId,
    Map<String, int>? unreadCounts,
    ChatType? type,
    String? groupName,
    String? groupImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    Map<String, dynamic>? metadata,
  }) {
    return Chat(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageText: lastMessageText ?? this.lastMessageText,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      unreadCounts: unreadCounts ?? this.unreadCounts,
      type: type ?? this.type,
      groupName: groupName ?? this.groupName,
      groupImage: groupImage ?? this.groupImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      metadata: metadata ?? this.metadata,
    );
  }
}

@HiveType(typeId: 41)
@JsonSerializable()
class Message {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String chatId;
  @HiveField(2)
  final String senderId;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final MessageType type;
  @HiveField(5)
  final List<MessageAttachment> attachments;
  @HiveField(6)
  final String? replyToMessageId;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final DateTime updatedAt;
  @HiveField(9)
  final MessageStatus status;
  @HiveField(10)
  final Map<String, DateTime> readBy;
  @HiveField(11)
  final bool isEdited;
  @HiveField(12)
  final DateTime? editedAt;
  @HiveField(13)
  final Map<String, dynamic>? metadata;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    this.type = MessageType.text,
    this.attachments = const [],
    this.replyToMessageId,
    required this.createdAt,
    required this.updatedAt,
    this.status = MessageStatus.sent,
    this.readBy = const {},
    this.isEdited = false,
    this.editedAt,
    this.metadata,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    MessageType? type,
    List<MessageAttachment>? attachments,
    String? replyToMessageId,
    DateTime? createdAt,
    DateTime? updatedAt,
    MessageStatus? status,
    Map<String, DateTime>? readBy,
    bool? isEdited,
    DateTime? editedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      attachments: attachments ?? this.attachments,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      readBy: readBy ?? this.readBy,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

@HiveType(typeId: 42)
@JsonSerializable()
class MessageAttachment {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final MessageAttachmentType type;
  @HiveField(2)
  final String url;
  @HiveField(3)
  final String? thumbnailUrl;
  @HiveField(4)
  final String fileName;
  @HiveField(5)
  final int fileSizeBytes;
  @HiveField(6)
  final String? mimeType;
  @HiveField(7)
  final double? duration;
  @HiveField(8)
  final int? width;
  @HiveField(9)
  final int? height;

  const MessageAttachment({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    required this.fileName,
    required this.fileSizeBytes,
    this.mimeType,
    this.duration,
    this.width,
    this.height,
  });

  factory MessageAttachment.fromJson(Map<String, dynamic> json) => 
      _$MessageAttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$MessageAttachmentToJson(this);
}

@HiveType(typeId: 43)
enum ChatType {
  @HiveField(0)
  @JsonValue('direct')
  direct,
  @HiveField(1)
  @JsonValue('group')
  group,
}

@HiveType(typeId: 44)
enum MessageType {
  @HiveField(0)
  @JsonValue('text')
  text,
  @HiveField(1)
  @JsonValue('image')
  image,
  @HiveField(2)
  @JsonValue('video')
  video,
  @HiveField(3)
  @JsonValue('audio')
  audio,
  @HiveField(4)
  @JsonValue('file')
  file,
  @HiveField(5)
  @JsonValue('location')
  location,
  @HiveField(6)
  @JsonValue('product')
  product,
  @HiveField(7)
  @JsonValue('system')
  system,
}

@HiveType(typeId: 45)
enum MessageStatus {
  @HiveField(0)
  @JsonValue('sending')
  sending,
  @HiveField(1)
  @JsonValue('sent')
  sent,
  @HiveField(2)
  @JsonValue('delivered')
  delivered,
  @HiveField(3)
  @JsonValue('read')
  read,
  @HiveField(4)
  @JsonValue('failed')
  failed,
}

@HiveType(typeId: 46)
enum MessageAttachmentType {
  @HiveField(0)
  @JsonValue('image')
  image,
  @HiveField(1)
  @JsonValue('video')
  video,
  @HiveField(2)
  @JsonValue('audio')
  audio,
  @HiveField(3)
  @JsonValue('document')
  document,
  @HiveField(4)
  @JsonValue('location')
  location,
}