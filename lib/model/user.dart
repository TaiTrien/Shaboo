class User {
  String _userID;
  String firstName;
  String lastName;
  String _password;
  String role = "USER";
  String email;
  String phone;
  String gender;
  String birthday;
  String _facebookID;
  String _googleID;
  String _facebookToken;
  String _googleToken;
  String avatar;

  User({
    String userID,
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
        _password = password,
        _facebookID = facebookID,
        _googleID = googleID,
        _facebookToken = facebookToken,
        _googleToken = googleToken;
}
