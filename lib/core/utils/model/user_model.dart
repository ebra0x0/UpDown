class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  List<Map<String, dynamic>>? buildings;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.buildings,
    this.token,
  });
}
