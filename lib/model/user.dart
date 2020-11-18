class ShabooUser {
  int _userID;
  String firstName;
  String lastName;
  String userName;
  String _password;
  String role = "USER";
  String email;
  String phone;
  String gender;
  String birthday;
  String avatar;

  ShabooUser({
    int userID,
    this.firstName,
    this.lastName,
    this.userName,
    String password,
    this.role,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    this.avatar,
  })  : _userID = userID,
        _password = password;
}
