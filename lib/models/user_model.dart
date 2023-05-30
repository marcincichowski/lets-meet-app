
class User {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  bool isSuperUser;

  User({
   required this.id,
   required this.username,
   required this.firstName,
   required this.lastName,
   required this.email,
   required this.isStaff,
   required this.isActive,
   required this.isSuperUser,
});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
      isSuperUser: json['is_superuser'],
    );
  }

}