import 'dart:async';

import 'package:flutter_taxiapp/src/firebase/firebase_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();

  Stream get nameStream => _nameController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get passStream => _passController.stream;

  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String email, String pass, String phone) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError("Input Name");
      return false;
    }
    _nameController.sink.add("");
    if (email == null || email.length == 0) {
      _emailController.sink.addError("Input Email");
      return false;
    }
    _emailController.sink.add("");
    if (phone == null || phone.length < 9 || phone.length > 11) {
      _phoneController.sink.addError("Input PhoneNumber");
      return false;
    }
    _phoneController.sink.add("");
    if (pass == null || pass.length < 6) {
      _passController.sink
          .addError("Password must be greater than 5 characters");
      return false;
    }
    _passController.sink.add("");
    return true;
  }

  void signUp(String email, String password, String phone, String name,Function onSuccess) {
    _firAuth.signUp(email, password, name, phone, onSuccess);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}
