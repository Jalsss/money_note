import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/home/analysis.dart';
import 'package:money_note/home/home.dart';
import 'package:money_note/home/other.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  LocalStorage storage = new LocalStorage('account');
  static var color = '#ffa500';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColor();
  }
  getColor() async {
    await storage.ready;
    var colors =  await storage.getItem('color');
    if(colors != null){
      setState(() {
        color = colors;
      });
    }
  }
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Analysis(),
    Other(),
  ];
  Widget tabBody = Container(
    color: Colors.white,
  );
  final Shader linearGradient = LinearGradient(
    colors: <Color>[ color == '#ff0000'? HexColor.fromHex('#ff0000') : HexColor.fromHex('#FFFF00'),
      color == '#ff0000'? HexColor.fromHex('#faf2d4') : HexColor.fromHex('#FaFF00')],
  ).createShader(Rect.fromLTWH(90.0, 0.0, 200.0, 70.0));

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
  List<String> listTitle = [
    'Cash Book',
    'Analysis',
    'Other'
  ];
  Widget getBar(int index) {
    return AppBar(
      title: Text(listTitle[index],
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
          foreground: Paint()..shader = linearGradient
      ),),
      centerTitle: false,
      backgroundColor: HexColor.fromHex(color),
      shadowColor: HexColor.fromHex(color),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: getBar(selectedIndex),
          backgroundColor: Colors.transparent,
          body: _widgetOptions.elementAt(selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: this.selectedIndex,
            selectedIconTheme:
                IconThemeData(color: Colors.red, opacity: 1.0, size: 45),
            unselectedIconTheme:
                IconThemeData(color: Colors.black45, opacity: 0.5, size: 25),
            onTap: (int index) {
              this.setState(() {
                this.selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Foundation.clipboard_notes),
                title: Text("Cash Book"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Entypo.line_graph),
                title: Text("Analysis"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.menu),
                title: Text("Other"),
              )
            ],
          ));
  }
}
