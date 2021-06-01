import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/model/im_ex.dart';

class AddDialog extends StatefulWidget {
  Function() add;
  AddDialog({Key key,this.add}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  static LocalStorage storage = new LocalStorage('account');
  String name;
  String total;
  int i =1;

  closeDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
  addData() async {
    await storage.ready;
    var data = await storage.getItem('target1');
    while (data != null) {
      data = await storage.getItem('target' + (i+1).toString());
      setState(() {
        i ++;
      });
    }
    if(name != null && total != null) {
      Import im = new Import(id: i, name: name, total: double.parse(total));
      Export ex = new Export(id: i, name: name, total: 0);
      ImEx ie = new ImEx(id: i, im : im, ex : ex);
      await storage.setItem('target' + (i).toString(), ie);
    }
    var add = widget.add;
    add();
    closeDialog();
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text('Thêm thành công'),
          );
        });
  }
  ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Colors.transparent),
    padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.fromLTRB(0, 0, 0, 0)),
    shadowColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
    overlayColor:
        MaterialStateColor.resolveWith((states) => Colors.transparent),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              width: MediaQuery.of(context).size.width * 0.92,
              height: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.topRight, children: <
                                Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.92,
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Add Target',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                  width: 40,
                                  child: TextButton(
                                    child: Icon(AntDesign.close),
                                    style: buttonStyle,
                                    onPressed: () => {closeDialog()},
                                  )),
                            ]),
                            TextField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                alignLabelWithHint: false,
                                labelText: 'Target name',
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black87, width: 1.0)),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  name = text;
                                });
                              },
                              cursorColor: Colors.black87,
                            ),
                            Container(
                              height: 5,
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                alignLabelWithHint: false,
                                labelText: 'Target total',
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black87, width: 1.0)),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  total = text;
                                });
                              },
                              cursorColor: Colors.black87,
                            )
                          ],
                        )),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              closeDialog();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.458,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.black26))),
                              child: Center(
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ),
                            style: buttonStyle),
                        Container(
                          color: Colors.black26,
                          width: 1,
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              addData();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.455,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.black26))),
                              child: Center(
                                child: Text('Add'),
                              ),
                            ),
                            style: buttonStyle)
                      ],
                    )
                  ]),
            )));
  }
}
