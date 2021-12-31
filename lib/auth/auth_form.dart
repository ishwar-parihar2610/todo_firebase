import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _userName = '';

  bool isLoginPage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLoginPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'InCorrect Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide(),
                          ),
                          labelText: "Enter Email",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'InCorrect Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Email",
                        labelStyle: GoogleFonts.roboto()),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'InCorrect Password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto()),
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () {},
                          child: isLoginPage
                              ? Text("Login",
                                  style: GoogleFonts.roboto(fontSize: 16))
                              : Text("SignUp",
                                  style: GoogleFonts.roboto(fontSize: 16)))),
                  SizedBox(height: 10),
                  Container(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              isLoginPage = !isLoginPage;
                            });
                          },
                          child: isLoginPage
                              ? Text('Not A Member ?')
                              : Text('Already a Member?')))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
