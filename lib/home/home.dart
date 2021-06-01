import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/dialog/add_dialog.dart';
import 'package:money_note/dialog/edit_dialog.dart';
import 'package:money_note/model/im_ex.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static LocalStorage storage = new LocalStorage('account');

  var color = '#ffa500';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getColor();
  }

  List<Import> imports = [];
  List<Export> exports = [];
  int i = 1;
  getColor() async{
    await storage.ready;
    var colors =  await storage.getItem('color');
    if(colors != null){
      setState(() {
        color = colors;
      });
    }
  }
  loadData() async {
    LocalStorage storage = new LocalStorage('account');
    await storage.ready;
    setState(() {
      imports = [];
      exports = [];
      i=1;
    });
    Map<String, dynamic> data = await storage.getItem('target1');
    while (i < 20) {
      setState(() {
        i++;
      });
      if(data != null) {
        ImEx ie = ImEx.fromJson(data);
        setState(() {
          imports.add(ie.im);
          exports.add(ie.ex);
        });
      }
      data = await storage.getItem('target' + i.toString());
    }
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
              child:Column(
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddDialog(
                              add: (){
                                loadData();
                              },
                            );
                          });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              color: Colors.black26,
                              width: 1.0,
                            ),
                            top: BorderSide(
                              //                    <--- top side
                              color: Colors.black26,
                              width: 1.0,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.height * 1,
                          height: 50,
                          child: Row(
                            children: [
                              Icon(
                                Foundation.plus,
                                color: Colors.black87,
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                'Add Target',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ),
                        )),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.65,
                    child:SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child:
                                  Text('Tiền dự chi',textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 20
                                    ),)
                              )
                            ],
                          ),
                          Wrap(
                              alignment: WrapAlignment.center,
                              children: List.generate(imports.length, (int i) {
                                return data(imports[i]);
                              })),

                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('Tiền thực tế',textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20
                                      ))
                              )
                            ],
                          ),
                          Wrap(
                              alignment: WrapAlignment.center,
                              children: List.generate(exports.length, (int i) {
                                return dataEX(exports[i]);
                              })),
                        ],
                      ),
                    )
                  )
                ],
              ),
            )));
  }

  Widget data(Import im) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return EditDialog(
                  add: (){
                    loadData();
                  },
                  nameEdit: im.name,
                  totalEdit: im.total.toString(),
                  idEdit: im.id,
                  isEx:false
                );
              });
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: Colors.black26,
                  width: 1.0,
                ),
                top: BorderSide(
                  //                    <--- top side
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      Text(
                        im.name,
                        style: TextStyle(color: Colors.black87),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      Text(
                        im.total.toString() + ' đ',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ],
              )
            )),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
          padding: MaterialStateProperty.resolveWith(
              (states) => EdgeInsets.fromLTRB(0, 0, 0, 0)),
          shadowColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ));
  }

  Widget dataEX(Export ex) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return EditDialog(
                    add: (){
                      loadData();
                    },
                    nameEdit: ex.name,
                    totalEdit: ex.total.toString(),
                    idEdit: ex.id,
                    isEx:true
                );
              });
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: Colors.black26,
                  width: 1.0,
                ),
                top: BorderSide(
                  //                    <--- top side
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      Text(
                        ex.name,
                        style: TextStyle(color: Colors.black87),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      Text(
                        ex.total.toString() + ' đ',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ],
              )
            )),
        style: ButtonStyle(
          backgroundColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
          padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.fromLTRB(0, 0, 0, 0)),
          shadowColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
          overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
        ));
  }
}
