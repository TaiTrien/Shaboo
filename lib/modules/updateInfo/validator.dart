class Validator {
  static isPhoneNumber(phoneNumber) {
    String pattern =
        r"^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$";
    return new RegExp(pattern).hasMatch(phoneNumber);
  }

  static isEmail(email) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return new RegExp(pattern).hasMatch(email);
  }

  static isName(String name) {
    if (name.trim().length <= 3) return false;
    return true;
  }

  static isPassword(String password) {
    String pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$%\^&\*]).{8,}$";
    // return new RegExp(pattern).hasMatch(password);
    return true;
  }

  static isReEnterPassword(String password, String reEnterPassword) {
    if (password != reEnterPassword) return false;
    return true;
  }
}
