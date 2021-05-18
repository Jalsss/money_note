import 'package:flutter/cupertino.dart';
import 'package:money_note/constant/hexcolor.dart';

class Other extends StatefulWidget {
  const Other({Key key}) : super(key: key);

  @override
  _OtherState createState() => _OtherState();
}

class _OtherState extends State<Other> {

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
              child: Container(),
            )
        ));
  }
}
