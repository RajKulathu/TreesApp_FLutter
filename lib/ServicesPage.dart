import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:sfui/LandingScreen.dart';
import 'ContactUs.dart';

Future<List<ActionGoals1>> getAllActionGoals() async{
  final response = await http.get('http://10.0.2.2:5000/ActionGoals');
  if(response.statusCode == 200 )
    {
      List actionGoalsJson = json.decode(response.body);
      return actionGoalsJson.map( (actionGoals) => ActionGoals1.fromJson(actionGoals)).toList();
    }
}
class ActionGoals1 {
  String applicationName;
  String iconPath;

  ActionGoals1({this.applicationName, this.iconPath});

  ActionGoals1.fromJson(Map<String, dynamic> json) {
    applicationName = json['ApplicationName'];
    iconPath = json['IconPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApplicationName'] = this.applicationName;
    data['IconPath'] = this.iconPath;
    return data;
  }
}

class ServicesPage extends StatefulWidget {
  ServicesPage({Key key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  Future<List<ActionGoals1>> ActionGoals;

  _ServicesPageState(){}

  @override
  void initState() {
    super.initState();
    ActionGoals = getAllActionGoals();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final listFetcherFromApi = FutureBuilder<List<ActionGoals1>>(
      future: ActionGoals,
      builder:(context,snapshot){
        List<ActionGoals1> data = snapshot.data;
        return ListView(
            padding: EdgeInsets.zero,
            children: data.map( (e) =>(
                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right),
                  leading: Image.asset(e.iconPath) ,
                  title: Text(e.applicationName),
                )
            )
            ).toList()
        );
      }
    );
    AppBar appBar = AppBar(title: Text('Services'), backgroundColor:Color(0xff6266F0));

    double headerHeight = kToolbarHeight + appBar.preferredSize.height -50;
    double BannerHeight = 150;
    final header =  Container(
      height: BannerHeight,
      width: size.width,
      decoration:  BoxDecoration(image: DecorationImage(fit: BoxFit.fill,
          image: AssetImage('assets/BannerMedium.PNG')
      )),
    );
    Drawer ticketDrawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'Home')},
          ),
          ListTile(
            title: Text('Home',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'Home')},
          ),
          ListTile(
            title: Text('Contact Us',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'ContactUs')},
          ),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        drawer: ticketDrawer,
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              header,
              Container(
                height: size.height - headerHeight -80,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,right: 8.0,left: 8.0),
                  child: listFetcherFromApi,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_onDrawerTileClicked(Context,Attribute){
  switch(Attribute) {
    case "Home":
      {
        Route route = MaterialPageRoute(
            builder: (context) => TreesLandingScreen(Attribute));
        Navigator.push(Context, route);
      }
      break;
    case "ContactUs":
      {
        Route route = MaterialPageRoute(
            builder: (context) => TreesContact(Attribute));
        Navigator.push(Context, route);
      }
      break;
  }
}


