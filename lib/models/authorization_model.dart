
class Authorization {
  String username;
  String role;
  int userId;


  Authorization({
    required this.username,
    required this.role,
    required this.userId,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      username: json['username'],
      role: json['role'],
      userId: json['user_id'],
    );
  }

   int getUserID(){
    return this.userId;
   }
}