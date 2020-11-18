class ShabooUser {
  int _userID;
  String firstName;
  String lastName;
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
    String password,
    this.role,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    String facebookID,
    String googleID,
    String facebookToken,
    String googleToken,
    this.avatar,
  })  : _userID = userID,
        _password = password;
}
