import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'KeyPeople.dart';
import 'AboutUs.dart';
import 'ContactUs.dart';
import 'ServicesPage.dart';

class TreesLandingScreen extends StatefulWidget {
  String loginUser;
  TreesLandingScreen(this.loginUser, {Key key}) : super(key: key);

  @override
  _TreesLandingScreenState createState() => _TreesLandingScreenState(loginUser);
}

class _TreesLandingScreenState extends State<TreesLandingScreen> {
  String loginUser;

  _TreesLandingScreenState(String loginUser){
    this.loginUser = loginUser;
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final listFetcher = Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Who We Are',style: TextStyle(fontSize: 25,color: Colors.lightBlueAccent),),
              subtitle: Text("""There’s a difference between known unknowns and unknown unknowns.
You can only Google things that you know you don’t know. When it comes to trying to find things that will work for you that you don’t know that you don’t know, you’re at the mercy of every smooth-talking snake-oil salesman and dopamine-hit app. """,
                style:TextStyle(fontSize: 20) ,),
              onTap: () => {  _onTileClicked(this.context,'KeyPeople')},
            ),
          ),
          Card(
            child: ListTile(
              title: Text('What We Do',style: TextStyle(fontSize: 25,color: Colors.lightBlueAccent),),
              subtitle: Text("""Trees solves these problems. The platform learns who you are and tells you what action plans worked for others like you. You don’t need to know what you don’t know. Trees will tell you. And when it tells you, it’s not something we profit from, it’s something that’s been empirically validated by the ratings and usage data of others. """,
                style:TextStyle(fontSize: 20) ,),
              onTap: () => {  _onTileClicked(this.context,'KeyPeople')},
            ),
          ),
          Card(
            child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Meet the Team',style: TextStyle(fontSize: 25,color: Colors.lightBlueAccent),),
              onTap: () => {  _onTileClicked(this.context,'KeyPeople')},
            ),
          ),
        ],
      ),
    );

    AppBar appBar = AppBar(title: Text('Welcome - ' + loginUser), backgroundColor:Color(0xff6266F0));

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
            onTap: () => { _onDrawerTileClicked(this.context, 'About')},
          ),
          ListTile(
            title: Text('About',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'About')},
          ),
          ListTile(
            title: Text('Contact Us',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'ContactUs')},
          ),
          ListTile(
            title: Text('Services',style: TextStyle(fontSize: 22),),
            onTap: () => { _onDrawerTileClicked(this.context, 'Services')},
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
                height: size.height - BannerHeight - 80,
                child: listFetcher,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
_onTileClicked(Context,Attribute){
  switch(Attribute){
    case "KeyPeople":{
      Route route = MaterialPageRoute(
          builder: (context) => KeyPeople());
      Navigator.push(Context, route);
    }
    break;
  }
}
_onDrawerTileClicked(Context,Attribute){
  switch(Attribute) {
    case "About":
      {
        Route route = MaterialPageRoute(
            builder: (context) => TreesAbout(Attribute));
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
    case "Services":
      {
        Route route = MaterialPageRoute(
            builder: (context) => ServicesPage());
        Navigator.push(Context, route);
      }
      break;
  }
}


