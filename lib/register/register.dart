import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/login/login.dart';
import 'package:money_note/model/account.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static LocalStorage storage = new LocalStorage('account');

  bool isLoading = false;
  bool loading = false;
  int accountId;
  String name;
  String userName;
  String password;
  String rePassword;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
  }

  // final facebookRegister = FacebookRegister();

  register() async {
    await storage.ready;
    // Map<String, dynamic> data = storage.getItem('account');
    // if (data == null) {
    //   setState(() {
    //     accountId = 1;
    //   });
    // } else {
    //   Account accounts = Account.fromJson(data);
    //
    // }
    if(password == rePassword) {
      setState(() {
        accountId = 1;
      });

      Account account = new Account(
          accountId: accountId,
          name: name,
          userName: userName,
          password: password);
      storage.setItem('account_value', account);
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Thanks!'),
          content: Text(
              'Đăng kí thành công'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
    } else {
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Thanks!'),
          content: Text(
              'Mật khẩu và nhắc lại mật khẩu không trùng khớp'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor.fromHex('#f85352'),
                    HexColor.fromHex('#ffa500'),
                  ],
                )),
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2),
                            child: Center(
                              child: Text(
                                'Money save',
                                style: TextStyle(
                                  fontSize: 48.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )),

                        Container(
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      alignLabelWithHint: false,
                                      contentPadding: EdgeInsets.all(20.0),
                                      hintText: 'Enter your name...',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                    ),
                                    cursorColor: Colors.black87,
                                    onChanged: (text) {
                                      setState(() {
                                        name = text;
                                      });
                                    },
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      alignLabelWithHint: false,
                                      contentPadding: EdgeInsets.all(20.0),
                                      hintText: 'Enter your username....',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                    ),
                                    cursorColor: Colors.black87,
                                    onChanged: (text) {
                                      setState(() {
                                        userName = text;
                                      });
                                    },
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      alignLabelWithHint: false,
                                      contentPadding: EdgeInsets.all(20.0),
                                      hintText: 'Enter your password....',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                    ),
                                    cursorColor: Colors.black87,
                                    onChanged: (text) {
                                      setState(() {
                                        password = text;
                                      });
                                    },
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      alignLabelWithHint: false,
                                      contentPadding: EdgeInsets.all(20.0),
                                      hintText: 'Re Enter your password...',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                    ),
                                    cursorColor: Colors.black87,
                                    onChanged: (text) {
                                      setState(() {
                                        rePassword = text;
                                      });
                                    },
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 20)),
                              button('REGISTER', () {
                                register();
                              }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("If you have account ? "),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                                      },
                                      child: Text('Login now!',style: TextStyle(decoration: TextDecoration.underline,),),
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) => Colors.transparent),
                                          padding: MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                  EdgeInsets.fromLTRB(0, 0, 0, 0)),
                                          shadowColor: MaterialStateColor.resolveWith(
                                                  (states) => Colors.transparent),
                                          overlayColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) => Colors.transparent)))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              )
            )));
  }

  Widget button(
      String text,
      Function() onclick,
      ) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black54.withOpacity(0.85),
        ),
        child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
              padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.fromLTRB(0, 0, 0, 0)),
              shadowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
              overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent)),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white38),
          ),
          onPressed: onclick,
        ));
  }
}
