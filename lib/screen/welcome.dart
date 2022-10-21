// flutter package
import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';

// Flie package inside screen folder
import 'login.dart';

class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  @override
  Widget build(BuildContext context) {
    // Current Device Size
    var size = MediaQuery.of(context).size;
    // Current Device Height
    var Screenheight = size.height;
    // Current Device Width
    var ScreenWidth = size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        "assets/icons/mic-svgrepo-com.svg",
                        height: 90.0,
                        width: 90.0,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text("Welcome To",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'MUSIC ',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'APP',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/loginpage');
                          },
                          child: Text(
                            'Login in',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(130, 40)),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Register',
                              style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                              minimumSize: Size(180, 40)),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text("Or quick login",
                            style: TextStyle(color: Colors.white)),
                        Text("with Touch ID",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 25.0,
                        ),
                        SvgIcon(
                          "assets/icons/finger-print-svgrepo-com.svg",
                          height: 90.0,
                          width: 90.0,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
