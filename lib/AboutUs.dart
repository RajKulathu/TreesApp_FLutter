import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:sfui/LandingScreen.dart';

import 'ContactUs.dart';

class TreesAbout extends StatefulWidget {
  String loginUser;
  TreesAbout(this.loginUser, {Key key}) : super(key: key);

  @override
  _TreesAboutState createState() => _TreesAboutState(loginUser);
}

class _TreesAboutState extends State<TreesAbout> {
  String loginUser;

  _TreesAboutState(String loginUser){
    this.loginUser = loginUser;
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    AppBar appBar = AppBar(title: Text('About Trees'), backgroundColor:Color(0xff6266F0));

    final VisionExpandible = Card(child: ExpansionTile(leading: Image.asset('assets/trees_vision.PNG'),title: Text('Vision',style: TextStyle(fontSize: 30),),
      children: <Widget>[
        SizedBox(
            width: 350, height: 280,
            child: Text('''Individuals thriving is the key to advancement. Systems help, then disappear into the background for anyone not working on them (think of plumbing, electricity, roads,  internet, politics, education). We have created a system to help individuals find their optimal path, that maximizes their meaning and contribution. This includes providing better ways for them to use existing systems, and ways for them to generate and share new systems.''',
              style: TextStyle(fontSize: 19),
            )),
      ],),);
    final MissionExpandible = Card(child: ExpansionTile(leading: Image.asset('assets/Mission.PNG'),title: Text('Mission',style: TextStyle(fontSize: 30),),
      children: <Widget>[
        SizedBox(
            width: 350, height: 380,
            child: Text('''Understand and help people as they try to help themselves and understand themselves.
‍
Help individuals choose activities, information, and entertainment that nudge them toward health, meaning, and self-improvement through mindful, evidence-based, and effective behaviors (rather than see them put their energy into activities that don’t serve them or improve the world).
‍
Harmonize and platform different ways of seeing the world and contributing to it, even if it takes a little more time (for our team and our customers).''',
              style: TextStyle(fontSize: 19),
            )),
      ],),);
    final ValuesExpandible = Card(child: ExpansionTile(leading: Image.asset('assets/Values_resized.png'),title: Text(' Values',style: TextStyle(fontSize: 30),),
      children: <Widget>[
        SizedBox(
            width: 350, height: 120,
            child: Text('''Intellectually honest
Transparent
Organized
Humble due to curiosity
Playful and athletic''',
              style: TextStyle(fontSize: 19),
            )),
      ],),);

    final listFetcher = Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          VisionExpandible,
          MissionExpandible,
          ValuesExpandible,
        ],
      ),
    );

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
        body:SingleChildScrollView(child:Column(
          children: <Widget>[
            header,
            Container(
              height: size.height - headerHeight -80,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 8.0,left: 8.0),
                child: listFetcher,
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


