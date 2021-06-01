import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';

import 'homepage.dart';

class Other extends StatefulWidget {
  const Other({Key key}) : super(key: key);

  @override
  _OtherState createState() => _OtherState();
}

enum SingingCharacter { YellowWhite, RedWhite, GreenWhite }

class _OtherState extends State<Other> {
  SingingCharacter _character = SingingCharacter.YellowWhite;
  LocalStorage storage = new LocalStorage('account');
  var color = '#ffa500';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColor();
  }

  getColor() async {
    await storage.ready;
    var colors = await storage.getItem('color');
    if (colors != null) {
      setState(() {
        color = colors;
      });
    }
    switch (color) {
      case '#ffa500':
        setState(() {
          _character = SingingCharacter.YellowWhite;
        });
        break;
      case '#00ff00':
        setState(() {
          _character = SingingCharacter.GreenWhite;
        });
        break;
      case '#ff0000':
        setState(() {
          _character = SingingCharacter.RedWhite;
        });
        break;
      default:
        break;
    }
  }

  changeColor() async {
    await storage.ready;
    await storage.deleteItem('color');
    switch (_character) {
      case SingingCharacter.YellowWhite:
        await storage.setItem('color', '#ffa500');
        break;
      case SingingCharacter.GreenWhite:
        await storage.setItem('color', '#00ff00');
        break;
      case SingingCharacter.RedWhite:
        await storage.setItem('color', '#ff0000');
        break;
      default:
        break;
    }
    getColor();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor.fromHex(color),
                HexColor.fromHex('#ffffff'),
              ],
            )),
            child: SafeArea(
              child: Container(
                child: Column(
                  children: <Widget>[
                    RadioListTile<SingingCharacter>(
                      title: const Text('Yellow-White'),
                      value: SingingCharacter.YellowWhite,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      title: const Text('Red-White'),
                      value: SingingCharacter.RedWhite,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      title: const Text('Green-White'),
                      value: SingingCharacter.GreenWhite,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    Container(
                      height: 60,
                    ),
                    Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.60,
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
                            'Ok',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white38),
                          ),
                          onPressed: () {
                            changeColor();
                          },
                        ))
                  ],
                ),
              ),
            )));
  }
}
