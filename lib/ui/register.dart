import 'dart:async';
import 'package:sandy_chandra_19411052/const/collor.dart';
import 'package:sandy_chandra_19411052/server/server.dart';
import 'package:sandy_chandra_19411052/ui/login.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class registerview extends StatefulWidget {
  const registerview({Key? key}) : super(key: key);

  @override
  _registerview createState() => _registerview();
}

class _registerview extends State<registerview> {
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllernama = new TextEditingController();
  TextEditingController controllertelp = new TextEditingController();
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> signup() async {
    var url = UrlServer + "users/sign-up";

    String email = controlleremail.text;
    String nama = controllernama.text;
    String telp = controllertelp.text;
    String password = controllerpassword.text;

      final response = await http.post(Uri.parse(url), body: {
        "email": email,
        "nama": nama,
        "telp": telp,
        "password": password
      });
      var result = convert.jsonDecode(response.body);

      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        print(Message);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>loginview()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, ErrorColor);
        print(Message);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // new Form(child: null,),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 15),
              child: Center(
                child: Container(
                  width: 250,
                  height: 200,
                  child: Image.asset("assets/reg.png"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Please Fill the Form Below',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),

            const
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllernama,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Name',
                    hintText: 'Type Your Name '),
                // controller: contr,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controlleremail,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Email',
                    hintText: 'Type Your Email'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllertelp,
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Phone Number',
                    hintText: 'Type Your Phone Number'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllerpassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Password',
                    hintText: 'Type Your Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Submit(context);
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => loginview()));
                },
                child: Text('Anda sudah punya akun? silahkan Login'),
              ),
            )
          ],
        ),
      ),
    );

    // );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      signup();
    } catch (error) {
      print(error);
    }
  }

}