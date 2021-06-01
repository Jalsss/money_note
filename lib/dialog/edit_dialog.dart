import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/model/im_ex.dart';

// ignore: must_be_immutable
class EditDialog extends StatefulWidget {
  Function() add;
  String nameEdit;
  String totalEdit;
  int idEdit;
  bool isEx;

  EditDialog(
      {Key key, this.add, this.idEdit, this.totalEdit, this.nameEdit, this.isEx})
      : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController totalController = new TextEditingController();
  static LocalStorage storage = new LocalStorage('account');
  String name;
  String total;
  int id;
  int i = 1;


  closeDialog() async {
    Navigator.of(context, rootNavigator: true).pop();
  }

  deleteItem() async {
    await Future.delayed(Duration(milliseconds: 300));
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text('Bạn có chắc chắn muốn xóa không?'),
            actions: [
              TextButton(onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              }, child: Text('Cancel')),
              TextButton(onPressed: () async {
                await storage.deleteItem('target' + id.toString());
                var add = widget.add;
                add();
                Navigator.of(context, rootNavigator: true).pop();
                return showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        title: Text('Thông báo'),
                        content: Text('Xóa thành công'),
                      );
                    });
              }, child: Text('OK'))
            ],);
        });
  }

  addData() async {
    await storage.ready;
    Map<String, dynamic> data = await storage.getItem('target' + id.toString());
    if (name != null && total != null) {
      if (widget.isEx) {
        Import im = ImEx
            .fromJson(data)
            .im;
        Export ex = new Export(id: ImEx
            .fromJson(data)
            .id, name: name, total: double.parse(total));
        ImEx ie = new ImEx(id: ImEx
            .fromJson(data)
            .id, im: im, ex: ex);
        await storage.deleteItem('target' + id.toString());
        await storage.setItem('target' + id.toString(), ie);
      } else {
        Import im = new Import(id: ImEx
            .fromJson(data)
            .id, name: name, total: double.parse(total));
        Export ex = ImEx
            .fromJson(data)
            .ex;
        ImEx ie = new ImEx(id: ImEx
            .fromJson(data)
            .id, im: im, ex: ex);
        await storage.deleteItem('target' + id.toString());
        await storage.setItem('target' + id.toString(), ie);
      }
    }
    var add = widget.add;
    add();
    closeDialog();
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text('Sửa thành công'),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      name = widget.nameEdit;
      total = widget.totalEdit;
      id = widget.idEdit;
      nameController.text = widget.nameEdit;
      totalController.text = widget.totalEdit;
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.92,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.92,
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Edit Target',
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
                              controller: nameController,
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
                              controller: totalController,
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
                              deleteItem();
                            },
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.458,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.black26))),
                              child: Center(
                                child: Text('Xóa',
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.455,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.black26))),
                              child: Center(
                                child: Text('Edit'),
                              ),
                            ),
                            style: buttonStyle)
                      ],
                    )
                  ]),
            )));
  }
}
