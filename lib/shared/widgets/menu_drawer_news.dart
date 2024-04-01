import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuDrawerNewsRoute extends StatefulWidget {
  MenuDrawerNewsRoute();

  @override
  MenuDrawerNewsRouteState createState() => new MenuDrawerNewsRouteState();
}

class MenuDrawerNewsRouteState extends State<MenuDrawerNewsRoute> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late BuildContext context;



  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      scaffoldKey.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Widget widget = Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Developer Profile"),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
   
      body: Container(),
    );
    return widget;
  }
}
