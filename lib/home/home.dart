import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:money_note/constant/hexcolor.dart';

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
                  TextButton(onPressed: (){

                  }, child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide( //                   <--- left side
                            color: Colors.black26,
                            width: 1.0,
                          ),
                          top: BorderSide( //                    <--- top side
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        )
                      ),
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 1,
                        height: 50,
                        child: Row(
                          children: [
                            Icon(Foundation.plus),
                            Container(width: 10,),
                            Text('Thêm khoản thu chi',)
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
