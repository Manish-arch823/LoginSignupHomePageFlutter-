// flutter packege
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart';
import 'package:svg_icon/svg_icon.dart';

// file  inside screen folder
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // variable for storing password visiblity on or off
  var _passwordVisibale;
  @override
  void initState() {
    _passwordVisibale = true;
    // TODO: implement initState
    super.initState();
  }

  // Email Controller
  TextEditingController emailCOntroller = TextEditingController();
  // Password Controller
  TextEditingController passwordController = TextEditingController();
// Form Key
  var _formKey = GlobalKey<FormState>();

// Submit Function For checking For is valid or not
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    login(emailCOntroller.text, passwordController.text);
  }

  // Login Function For Call login api
  void login(String email, String password) async {
    print("Email $email and Password $password");
    try {
      // Loader Start
      Loader.show(context,
          isSafeAreaOverlay: false,
          isBottomBarOverlay: false,
          overlayFromBottom: 80,
          overlayColor: Colors.black26,
          progressIndicator:
              CircularProgressIndicator(backgroundColor: Colors.red),
          themeData: Theme.of(context).copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.green)));
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          headers: headers,
          body: {
            'email': email,
            'password': password,
          });
      if (response.statusCode == 200) {
        print("Account created successfully ${response.body} ");

        Navigator.pushNamed(context, '/homepage');

        // Loader Hide
        Loader.hide();
      } else {
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 52.0,
                        ),
                        SvgIcon(
                          "assets/icons/mic-svgrepo-com.svg",
                          height: 70.0,
                          width: 70.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "SIGN IN ",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text("TO CONTINUE", style: TextStyle(fontSize: 15.0))
                      ],
                    ))),
            Expanded(
                flex: 3,
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            textAlign: TextAlign.left,
                            controller: emailCOntroller,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                              hintText: 'Enter email',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            obscureText: _passwordVisibale,
                            textAlign: TextAlign.left,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid password!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisibale
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisibale = !_passwordVisibale;
                                  });
                                },
                              ),
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                              fillColor: Color.fromRGBO(243, 243, 243, 1),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                gradient: new LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(18, 203, 224, 1),
                                    // Color.fromRGBO(119, 115, 238, 1),
                                    Color.fromRGBO(77, 151, 232, 1),
                                    Color.fromRGBO(189, 55, 246, 1)
                                  ],
                                  //     stops: [
                                  //   0.2,
                                  //   0.1
                                  // ]
                                )),
                            child: ElevatedButton(
                              onPressed: () {
                                _submit();
                              },
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  foregroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15), // <-- Radius
                                  ),
                                  minimumSize: Size(140, 40)),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Lost password?",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      ),
                    ))),
            Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 33.0,
                              // width: 80.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(18, 203, 224, 1),
                                      // Color.fromRGBO(119, 115, 238, 1),
                                      Color.fromRGBO(77, 151, 232, 1),
                                      Color.fromRGBO(189, 55, 246, 1)
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Chip(
                                elevation: 20,
                                padding: EdgeInsets.all(8),
                                // backgroundColor: Colors.greenAccent[100],
                                shadowColor: Colors.transparent,
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                      "assets/icons/icons8-google-48.png"), //NetworkImage
                                ), //CircleAvatar
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Google',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ), //Text
                              ),
                            ),
                            Container(
                              height: 33.0,
                              // width: 80.0,
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(18, 203, 224, 1),
                                      // Color.fromRGBO(119, 115, 238, 1),
                                      Color.fromRGBO(77, 151, 232, 1),
                                      Color.fromRGBO(189, 55, 246, 1)
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Chip(
                                elevation: 20,
                                padding: EdgeInsets.all(8),
                                // backgroundColor: Colors.greenAccent[100],
                                shadowColor: Colors.transparent,
                                avatar: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/icons/icons8-facebook-48.png"), //NetworkImage
                                ), //CircleAvatar
                                label: Text(
                                  'Facebook',
                                  style: TextStyle(fontSize: 14),
                                ), //Text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.0),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 140.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' Register',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
