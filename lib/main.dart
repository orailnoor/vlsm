import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vlossom/Pages/_sign.dart';
import 'package:vlossom/Pages/explore.dart';

import 'package:vlossom/Pages/homepage.dart';

import 'package:vlossom/Widgets/prgressbar.dart';
import 'package:vlossom/recordings/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.grey),
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
