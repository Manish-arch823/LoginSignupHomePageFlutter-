import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';

import '../model/user_model.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Calling Get User  Api
  Future<user> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/user?page=2"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return user.fromJson(data);
    } else {
      print("response.statusCode_____${response.statusCode}");
      print('faild');
      return user.fromJson(data);
    }
  }

  // Converting hex Color to read able to flutter removiing # lmfrom hex color
  int hexColor(String c) {
    String sColor = '0xff' + c;
    sColor = sColor.replaceAll('#', '');
    int dColor = int.parse(sColor);
    return dColor;
  }

  Color _colorContainer = Colors.blue;

  //  Variable For Storing Card which one is selected now
  var currentCard;

  late Future<user> userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = this.getUserApi();
  }

  @override
  Widget build(BuildContext context) {
    // Current Device Size
    var size = MediaQuery.of(context).size;
    // Current Device Height
    var Screenheight = size.height;
    // Current Device Width
    var ScreenWidth = size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(' Manish Singh '),
              ),
              ListTile(
                title: Center(child: const Text('Logout ')),
                onTap: () {
                  Navigator.pushNamed(context, '/loginpage');
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 203, 169, 1),
            title: Center(
              child: Text(
                "CONTACTS",
                style: TextStyle(color: Colors.white),
              ),
            )),
        body: Stack(
          children: [
            Column(children: [
              Expanded(
                  child: FutureBuilder<user>(
                      future: userData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: Stack(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentCard = index;
                                            });
                                          },
                                          child: Card(
                                            color: (currentCard == index)
                                                ? Color.fromRGBO(
                                                    198, 161, 232, 1)
                                                : (index % 2 == 0)
                                                    ? Colors.grey
                                                    : Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 100.0,
                                                      width: 150.0,
                                                      child: Image.asset(
                                                        "assets/icons/marvin-meyer-SYTO3xs06fU-unsplash.jpg",
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .name!
                                                              .capitalize(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.0),
                                                        ),
                                                        Text(snapshot.data!
                                                            .data![index].year
                                                            .toString()),
                                                      ],
                                                    ),
                                                    (currentCard == index)
                                                        ? Row(
                                                            children: [
                                                              Icon(Icons.phone),
                                                              SizedBox(
                                                                width: 5.0,
                                                              ),
                                                              Icon(Icons
                                                                  .message),
                                                            ],
                                                          )
                                                        : Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  hexColor(snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .color
                                                                      .toString())),
                                                            ),
                                                          ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue));
                        }
                      })),
            ]),
            Positioned(
              right: 20.0,
              bottom: 20.0,
              child: Image.asset(
                "assets/icons/plus.png",
                height: 50.0,
                width: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension for  capitalizing First letter of user name
extension FirstLetterCapital on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toString()}";
  }
}
