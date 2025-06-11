class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;

  Address({
    this.street,
    this.city,
    this.state,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'state': state,
        'postalCode': postalCode,
      };
}

class UserDetails {
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? photoUrl;
  final List<Address>? address;
  final Address? lastUsedAddress;

  UserDetails({
    this.name,
    this.email,
    this.phoneNo,
    this.photoUrl,
    this.address,
    this.lastUsedAddress,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json['name'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        photoUrl: json['photoUrl'],
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e))
            .toList(),
        lastUsedAddress: json['lastUsedAddress'] != null
            ? Address.fromJson(json['lastUsedAddress'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'photoUrl': photoUrl,
        'address': address?.map((e) => e.toJson()).toList(),
        'lastUsedAddress': lastUsedAddress?.toJson(),
      };
}
