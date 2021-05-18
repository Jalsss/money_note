import 'package:flutter/material.dart';

import 'login/login.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.teal[200], // All text is black
          primaryTextTheme: Typography().black,  // ALL text is white

        ),
        debugShowCheckedModeBanner: false,
        home: Login(),
      )
  );
}

