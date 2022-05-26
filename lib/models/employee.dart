import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.id,
    this.name,
    this.username,
    this.email,
    this.profileImage,
    this.phone,
    this.website,
  });

  int? id;
  String? name;
  String? username;
  String? email;
  String? profileImage;

  String? phone;
  String? website;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        phone: json["phone"] == null ? null : json["phone"],
        website: json["website"] == null ? null : json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "profile_image": profileImage == null ? null : profileImage,
        "phone": phone == null ? null : phone,
        "website": website == null ? null : website,
      };
}
