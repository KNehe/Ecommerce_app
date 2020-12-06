class ShippingDetails {
  ShippingDetails({
    this.id,
    this.name,
    this.phoneContact,
    this.addressLine,
    this.city,
    this.postalCode,
    this.country,
  });

  String id;
  String name;
  String phoneContact;
  String addressLine;
  String city;
  String postalCode;
  String country;

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        id: json["_id"],
        name: json["name"],
        phoneContact: json["phoneContact"],
        addressLine: json["addressLine"],
        city: json["city"],
        postalCode: json["postalCode"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phoneContact": phoneContact,
        "addressLine": addressLine,
        "city": city,
        "postalCode": postalCode,
        "country": country,
      };
}
