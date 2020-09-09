import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'LandingScreen.dart';

class TreesHomeScreen extends StatefulWidget {
  @override
  _TreesHomeScreenState createState() => _TreesHomeScreenState();
}

class _TreesHomeScreenState extends State<TreesHomeScreen> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final TreesIdController = TextEditingController();

  @override
  void dispose() {
    TreesIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final header = Container(
      height: 400,
      width: size.width,
      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fitWidth,
          image: AssetImage('assets/treesMainLogo.PNG'))),
    );
    final emailField = TextField(
      textAlign: TextAlign.center,
      controller: TreesIdController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(hintText: "Trees ID",),
    );
    final enterButton = Material(
      elevation: 5.0,
      shadowColor: Colors.blue.withOpacity(0.1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        color: Color(0xff4F53D0),
        onPressed: () {EnterPressed(this.context, TreesIdController);},
        child: Text("Enter",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              header,
              Container(
                child:
                Container(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(children: <Widget>[
                    emailField,
                    SizedBox(height: 15.0),
                    enterButton,
                  ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

RouteReDirect(Context, Username) {
  Route route = MaterialPageRoute(
      builder: (context) => TreesLandingScreen(Username));
  Navigator.push(Context, route);
}

EnterPressed(Context, TreesIdController) async {
  var treesEmployees_Url = 'https://jsonplaceholder.typicode.com/users';
  final apiResponse = await get(treesEmployees_Url);

  if(apiResponse.statusCode == 200){
    var treesEmployees = json.decode(apiResponse.body);
    var employeeName;
    var authenticated = false;

    for(final employee in treesEmployees) {
          if(TreesIdController.text == employee['email'])
            {
              authenticated = true;
              employeeName = employee['name'];
              break;
            }
        }
    if(authenticated)
      RouteReDirect(Context, employeeName);
  }
  else{
    throw Exception('Pleae try again later');
  }
}