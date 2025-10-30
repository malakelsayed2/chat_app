class UserModel{

  final String email ;
  final String username ;
  final String id ;

  const UserModel({
    required this.email,
    required this.username,
    required this.id,
  });

  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
        email: map["email"],
        id: map["id"],
        username: map["username"]);
  }

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "username": username,
      "email": email
    };
  }
}