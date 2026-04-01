import 'package:blood_donation_app/app/data/model/user.dart';

class BloodRequestPost {
  int? id;
  int? userId;
  String? name;
  String? hospital;
  String? location;
  String? phone;
  String? bloodGroup;
  int? unit;
  String? time;
  String? date;
  String? status;
  String? reason;
  String? description;
  String? createdAt;
  String? updatedAt;
  User? user;

  BloodRequestPost(
      {this.id,
        this.userId,
        this.name,
        this.hospital,
        this.location,
        this.phone,
        this.bloodGroup,
        this.unit,
        this.time,
        this.date,
        this.status,
        this.reason,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.user});

  BloodRequestPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    hospital = json['hospital'];
    location = json['location'];
    phone = json['phone'];
    bloodGroup = json['blood_group'];
    unit = json['unit'];
    time = json['time'];
    date = json['date'];
    status = json['status'];
    reason = json['reason'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['hospital'] = this.hospital;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['blood_group'] = this.bloodGroup;
    data['unit'] = this.unit;
    data['time'] = this.time;
    data['date'] = this.date;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}