class Donors {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String profileImage;
  final String blood;
  final String division;
  final String district;
  final String upazila;
  final String fullAddress;
  final String lastDonationDate;
  final String facebookLink;
  final String details;

  Donors({
    this.id = 0,
    this.name = '',
    this.phone = '',
    this.email = '',
    this.profileImage = '',
    this.blood = '',
    this.division = '',
    this.district = '',
    this.upazila = '',
    this.fullAddress = '',
    this.lastDonationDate = '',
    this.facebookLink = '',
    this.details = '',
  });

  factory Donors.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Donors();
    }

    return Donors(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'] ?? '',
      blood: json['blood'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      upazila: json['upazila'] ?? '',
      fullAddress: json['full_address'] ?? '',
      lastDonationDate: json['last_donation_date'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      details: json['details'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'profile_image': profileImage,
      'blood': blood,
      'division': division,
      'district': district,
      'upazila': upazila,
      'full_address': fullAddress,
      'last_donation_date': lastDonationDate,
      'facebook_link': facebookLink,
      'details': details,
    };
  }
}