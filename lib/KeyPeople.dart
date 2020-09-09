import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'KeyPeopleAsAGrid.dart';
import 'LandingScreen.dart';

Future<List<TreesEmployees>> Get_All_Employees() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/users');
  if (response.statusCode == 200) {
    print(response.body);
    List responseJson = json.decode(response.body);
    return responseJson.map( (m) => new TreesEmployees.fromJson(m) ).toList();
//    return responseJson.where((d) => d['Attribute'] == "category").map( (m) => new TreesEmployees.fromJson(m) ).toList();
  } else {
    throw Exception('Failed to load api_get');
  }
}
class TreesEmployees {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  TreesEmployees(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone,
        this.website,
        this.company});

  TreesEmployees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}
class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo.toJson();
    }
    return data;
  }
}
class Geo {
  String lat;
  String lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}

class KeyPeople extends StatefulWidget {
  KeyPeople({Key key}) : super(key: key);

  @override
  _KeyPeopleState createState() => _KeyPeopleState();
}

class _KeyPeopleState extends State<KeyPeople> {

  Future<List<TreesEmployees>> futureGetAllEmployees;

  @override
  void initState() {
    super.initState();
    futureGetAllEmployees = Get_All_Employees();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AppBar appBar = AppBar(title: Text('Trees Team!'), backgroundColor:Color(0xff6266F0),actions: [ IconButton(
    icon: Icon(Icons.home),
        onPressed: () => _takeMeHome(this.context))]);
    double headerHeight = kToolbarHeight + appBar.preferredSize.height + 50;
    final header =  Container(
      height: headerHeight - appBar.preferredSize.height -50,
      width: size.width,
      decoration:  BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/HeaderCurtain.png') )),
    );

    Drawer ticketDrawer = Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'Grid')},
          ),
          ListTile(
            title: Text('GridView',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'Grid')},
          ),
          ListTile(
            title: Text('ListView',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'Table')},
          ),
        ],
      ),
    );

    List<DataColumn> ticketsGridColumnHeaders = <DataColumn>[
      DataColumn(
        label: Text(
          'Name',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Phone',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Email',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ];

    Widget employeesFromApi = FutureBuilder<List<TreesEmployees>>(
          future: futureGetAllEmployees,
          builder: (context, snapshot) {
            List<TreesEmployees> data = snapshot.data;
            return
              DataTable(
                columns: ticketsGridColumnHeaders,
                rows: data.map((employee) =>
                    DataRow(
                        cells: <DataCell>[
                          DataCell(Text(employee.name)),
                          DataCell(Text(employee.phone)),
                          DataCell(Text(employee.website)),
                        ]
                    )
                ).toList(),
              );
          }
      );

    return Scaffold(
      appBar: appBar,
      drawer: ticketDrawer,
      body: Column(
        children: <Widget>[
          header,
          Container(
            height: size.height - headerHeight,
            padding: EdgeInsets.only(left: 0, top: 0, right: 30, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                employeesFromApi,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_onDrawerTileClicked(Context,Attribute){
  switch(Attribute) {
    case "Grid":
      {
        Route route = MaterialPageRoute(
            builder: (context) => KeyPeopleAsAGrid());
        Navigator.push(Context, route);
      }
      break;
    case "Table":
      {
        Route route = MaterialPageRoute(
            builder: (context) => KeyPeople());
        Navigator.push(Context, route);
      }
      break;
  }
}
_takeMeHome(Context) {
  Route route = MaterialPageRoute(builder: (context) => TreesLandingScreen('Home'));
  Navigator.pushReplacement(Context, route);
}