import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:sfui/LandingScreen.dart';

class TreesContact extends StatefulWidget {
  String loginUser;

  TreesContact(this.loginUser, {Key key}) : super(key: key);

  @override
  _TreesContactState createState() =>
      _TreesContactState();
}

class _TreesContactState extends State<TreesContact> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    AppBar appBar = AppBar(title: Text('Contact Us'),actions: [ IconButton(
      icon: Icon(Icons.home),
      onPressed: () => _takeMeHome(this.context),
    ),],
        backgroundColor:Color(0xff6266F0));

    final header =  SizedBox(height: 60,child:Container(
      width: size.width,
      decoration:  BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/HeaderCurtain.png') )),
    ));

    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final myNameController = TextEditingController();
    final myEmailaddressController = TextEditingController();
    final myMessageController = TextEditingController();
    final Name = TextField(
      textAlign: TextAlign.center,
      controller: myNameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(hintText: "Enter your Name",),
    );
    final Email = TextField(
      textAlign: TextAlign.center,
      controller: myEmailaddressController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(hintText: "Enter your Email",),
    );
    final Message = TextField(
      textAlign: TextAlign.center,
      controller: myMessageController,
      obscureText: false,
      style: style,
      maxLines: 5,
      decoration: InputDecoration(hintText: "Hi there, I'm reaching out because I think we can collaborate...",),
    );

    final ContactCard = Card(child: ExpansionTile( title: Text('''Contact Jack@trees.app''')));
    final OfficeCard = Card(child:
    ExpansionTile( title: Text('''Our Office''',style: TextStyle(fontSize: 18),),
      children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text('''Our team works out of the Cal Poly Center for Innovation & Entrepreneurship HotHouse''',
        style: TextStyle(fontSize: 17),),
      )
    ],
    )
    );
    final AddressCard = Card(child:
    ExpansionTile( title: Text('''Address''',style: TextStyle(fontSize: 18)),children: <Widget>[
      Text('''872 Higuera Street,
San Luis Obispo,
CA 93401''',style: TextStyle(fontSize: 17))
    ],
    )
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                header,
                Container(
                  child: Container(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(children: <Widget>[
                      Name,
                      SizedBox(height: 15.0),
                      Email,
                      SizedBox(height: 15.0),
                      Message,
                      SizedBox(height: 15.0),
                      OfficeCard,
                      AddressCard,
                      ContactCard,
                    ],),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          crossAxisAlignment:CrossAxisAlignment.end ,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(width: 10),
            FloatingActionButton(
              tooltip: 'Submit',
              child: Icon(Icons.send), onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

_takeMeHome(Context) {
  Route route = MaterialPageRoute(builder: (context) => TreesLandingScreen('Home'));
  Navigator.pushReplacement(Context, route);
//  Navigator.push(Context, route);
}
