import 'package:flutter/cupertino.dart';
import 'package:money_note/constant/hexcolor.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key key}) : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
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
