import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/dialog/add_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor.fromHex('#ffa500'),
                HexColor.fromHex('#ffffff'),
              ],
            )),
            child: SafeArea(
              child: Column(
                children: [
                  TextButton(
                    onPressed: (){
                    showDialog(context: context, builder: (context) {
                      return AddDialog();
                    });
                  }, child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide( //                   <--- left side
                            color: Colors.black26,
                            width: 1.0,
                          ),
                          top: BorderSide( //                    <--- top side
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 1,
                        height: 50,
                        child: Row(
                          children: [
                            Icon(Foundation.plus,color: Colors.black87,),
                            Container(width: 10,),
                            Text('Add Target', style: TextStyle(
                              color: Colors.black87
                            ),)
                          ],
                        ),
                      )),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor
                          .resolveWith((states) =>
                      Colors.transparent),
                      padding: MaterialStateProperty.resolveWith((
                          states) => EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      shadowColor: MaterialStateColor.resolveWith((
                          states) => Colors.transparent),
                      overlayColor: MaterialStateColor.resolveWith((
                          states) => Colors.transparent),

                  ),)
                ],
              ),
            )));
  }
}
