import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'login/login.dart';

void main(){
  data() async {

    LocalStorage storage = new LocalStorage('account');
    await storage.ready;
    var color = await storage.getItem('color');
    if(color == null){
      await storage.setItem('color','#ffa500');
    }
  }
  data();
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

