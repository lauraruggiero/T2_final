class User {
  String email;
  String password;

  User({this.email, this.password});

  User.fromDatabaseJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toDatabaseJson() => {
        //final Map<String, dynamic> data = new Map<String, dynamic>();
        "email": this.email,
        "password": this.password,
      };
}
