
class UsersModel {
  int id;
  String fullName;
  int phone;
  String location;

  UsersModel(
      {required this.id,
      required this.fullName,
      required this.phone,
      required this.location});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json["id"]??0,
      fullName: json["fullName"]??"",
      phone: json["phone"]??0,
      location: json["location"]??0,
    );
  }
}
