import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String message;
  String date;
  String time;
  bool isSeen;
  String senderId;
  String receiverId;
  String? imageUrl;
  MessageModel({
    required this.message,
    required this.date,
    required this.time,
    required this.isSeen,
    required this.senderId,
    required this.receiverId,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'date': date,
      'time': time,
      'isSeen': isSeen,
      'senderId': senderId,
      'receiverId': receiverId,
      'imageUrl': imageUrl,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      isSeen: map['isSeen'] as bool,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
