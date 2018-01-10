import 'dart:async';

import 'package:flutter/material.dart';

import 'facebook.dart' as fb;

const String appId = "your app id";
const String appSecret = "your app secret";

Future<Null> main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  fb.Token token;
  fb.FacebookGraph graph;
  fb.PublicProfile profile;

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return new MaterialApp(
        title: 'Facebook Oauth Example',
        home: new Scaffold(
          body: new Center(
            child: new RaisedButton(
              child: new Text("Login with Facebook"),
              onPressed: () async {
                final fb.Token _token = await fb.getToken(appId, appSecret);
                fb.FacebookGraph _graph = new fb.FacebookGraph(_token);
                fb.PublicProfile _profile = await _graph.me(["name"]);
                setState(() {
                  token = _token;
                  graph = _graph;
                  profile = _profile;
                });
              },
            ),
          ),
        ),
      );
    }
    return new Scaffold(
      body: new Center(child: new Text("Hello ${profile.name}")),
    );
  }
}
