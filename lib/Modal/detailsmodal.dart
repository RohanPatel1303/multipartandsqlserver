// To parse this JSON data, do
//
//     final detailsModal = detailsModalFromJson(jsonString);

import 'dart:convert';

class DetailsModal {
  DetailsModal({
    this.email,
    this.password,
    this.purpose,
    this.typeOfFood,
  });

  String? email;
  String? password;
  String? purpose;
  String? typeOfFood;

  factory DetailsModal.fromRawJson(String str) => DetailsModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailsModal.fromJson(Map<String, dynamic> json) => DetailsModal(
    email: json["email"],
    password: json["password"],
    purpose: json["purpose"],
    typeOfFood: json["type_of_food"],
  );

  Map<String, String?> toJson() => {
    "email": email,
    "password": password,
    "purpose": purpose,
    "type_of_food": typeOfFood,
  };
}
