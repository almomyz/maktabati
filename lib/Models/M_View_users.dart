class Users {
  final String user_password;
  final String user_email;
  final String user_name;
  final String user_id;

  const Users({

    required this.user_password,
    required this.user_email,
    required this.user_name,
    required this.user_id,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(

    user_id: json['user_id'],
    user_name: json['user_name'],
    user_email: json['user_email'],
    user_password: json['user_password'],
  );

  Map<String, dynamic> toJson() => {

    'user_id': user_id,
    'user_name': user_name,
    'user_email': user_email,
    'user_password': user_password,
  };
}
