import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:maaap/signin.dart';
import 'const.dart';
import 'home.dart';

class Signup extends StatefulWidget {
  const Signup({Key?
  
   key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();

  Future<void> addData() async {
    if (_formKey.currentState!.validate()) {
      var data = {
        'name': name.text,
        'email': email.text,
        'mobile': mobile.text,
        'password': password.text,
      };
      var response = await post(Uri.parse('${Con.url}register.php'), body: data);
      var res = jsonDecode(response.body);
      if (res['message'] == 'Added') {
        Fluttertoast.showToast(msg: 'Registration Successful...');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Signin();
        }));
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong...!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Lottie.asset('assets/img/signup.json', height: 150, width: 150),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: TextFormField(
                  controller: mobile,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 15,
                  bottom: 20,
                ),
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              InkWell(
                onTap: addData,
                child: Container(
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromARGB(255, 255, 181, 176),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
