import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/home/homepage.dart';
import 'package:money_note/model/account.dart';
import 'package:money_note/register/register.dart';
// import 'package:http/http.dart';

// final _storage = new LocalStorage();

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static LocalStorage storage = new LocalStorage('account');

  bool isLoading = false;
  bool loading = false;
  String userName = '';
  String password = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
  }

  // final facebookLogin = FacebookLogin();

  login() async {
    await storage.ready;
    Map<String, dynamic> data = storage.getItem('account_value');
    if(data != null) {
      Account account = Account.fromJson(data);
      if (account != null && userName != '' && password != '') {
        if (userName != account.userName || password != account.password) {
          return showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text('Thanks!'),
              content: Text(
                  'Tên tài khoản hoặc mật khẩu không chính xác'),
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
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      } else {
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Thanks!'),
            content: Text(
                'Vui lòng nhập đầy đủ tên tài khoản và mật khẩu'),
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
    } else {
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Thanks!'),
          content: Text(
              'Tên tài khoản hoặc mật khẩu không chính xác'),
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
                                }
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
                                }
                            )),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        button('LOG IN', () {
                          login();
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("If you don't have account ? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                },
                                child: Text('Register now!',style: TextStyle(decoration: TextDecoration.underline,),),
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
