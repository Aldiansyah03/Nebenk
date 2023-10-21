import 'package:flutter/material.dart';


class AuthProvider extends ChangeNotifier{
  final  Form = GlobalKey<FormState>();

  var isilogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  void submit(){
    final _isvalid = Form.currentState!.validate();

    if(!_isvalid){
      return;
    }
    
    Form.currentState!.save();
  }
}