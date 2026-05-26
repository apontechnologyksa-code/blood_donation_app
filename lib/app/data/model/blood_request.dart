import 'package:blood_donation_app/app/data/model/user.dart';

class BloodRequestPost {
  final int id;
  final int userId;
  final String name;
  final String hospital;
  final String location;
  final String phone;
  final String bloodGroup;
  final int unit;
  final String time;
  final String date;
  final String status;
  final String reason;
  final String description;
  final String createdAt;
  final String updatedAt;
  final User? user;

  BloodRequestPost({
    this.id = 0,
    this.userId = 0,
    this.name = '',
    this.hospital = '',
    this.location = '',
    this.phone = '',
    this.bloodGroup = '',
    this.unit = 0,
    this.time = '',
    this.date = '',
    this.status = '',
    this.reason = '',
    this.description = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.user,
  });

  /// 🔥 SAFE INT PARSER (IMPORTANT)
  static int safeInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  factory BloodRequestPost.fromJson(Map<String, dynamic>? json) {
    if (json == null) return BloodRequestPost();

    return BloodRequestPost(
      id: safeInt(json['id']),
      userId: safeInt(json['user_id']),
      name: json['name'] ?? '',
      hospital: json['hospital'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      bloodGroup: json['blood_group'] ?? '',
      unit: safeInt(json['unit']),
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'hospital': hospital,
      'location': location,
      'phone': phone,
      'blood_group': bloodGroup,
      'unit': unit,
      'time': time,
      'date': date,
      'status': status,
      'reason': reason,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }
}