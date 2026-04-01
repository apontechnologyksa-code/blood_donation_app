class Donors {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? profileImage;
  String? blood;
  String? division;
  String? district;
  String? upazila;
  String? fullAddress;
  String? lastDonationDate;
  String? facebookLink;
  String? details;

  Donors(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.profileImage,
        this.blood,
        this.division,
        this.district,
        this.upazila,
        this.fullAddress,
        this.lastDonationDate,
        this.facebookLink,
        this.details});

  Donors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profileImage = json['profile_image'];
    blood = json['blood'];
    division = json['division'];
    district = json['district'];
    upazila = json['upazila'];
    fullAddress = json['full_address'];
    lastDonationDate = json['last_donation_date'];
    facebookLink = json['facebook_link'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['blood'] = this.blood;
    data['division'] = this.division;
    data['district'] = this.district;
    data['upazila'] = this.upazila;
    data['full_address'] = this.fullAddress;
    data['last_donation_date'] = this.lastDonationDate;
    data['facebook_link'] = this.facebookLink;
    data['details'] = this.details;
    return data;
  }
}