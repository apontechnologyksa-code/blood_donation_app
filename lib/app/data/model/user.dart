class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? profileImage;
  String? facebookLink;
  String? details;
  String? blood;
  String? division;
  String? district;
  String? upazila;
  String? fullAddress;
  String? lastDonationDate;
  String? userType;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.profileImage,
        this.facebookLink,
        this.details,
        this.blood,
        this.division,
        this.district,
        this.upazila,
        this.fullAddress,
        this.lastDonationDate,
        this.userType,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profileImage = json['profile_image'];
    facebookLink = json['facebook_link'];
    details = json['details'];
    blood = json['blood'];
    division = json['division'];
    district = json['district'];
    upazila = json['upazila'];
    fullAddress = json['full_address'];
    lastDonationDate = json['last_donation_date'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['facebook_link'] = this.facebookLink;
    data['details'] = this.details;
    data['blood'] = this.blood;
    data['division'] = this.division;
    data['district'] = this.district;
    data['upazila'] = this.upazila;
    data['full_address'] = this.fullAddress;
    data['last_donation_date'] = this.lastDonationDate;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}