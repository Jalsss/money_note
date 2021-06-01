import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_note/constant/hexcolor.dart';
import 'package:money_note/model/im_ex.dart';

import 'indicator.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key key}) : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  LocalStorage storage = new LocalStorage('account');

  var color = '#ffa500';
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getColor();
  }
  getColor() async{
    await storage.ready;
    var colors =  await storage.getItem('color');
    if(colors != null){
      setState(() {
        color = colors;
      });
    }
  }
  List<Import> imports = [];
  List<Export> exports = [];
  int i = 1;
  double totalEx = 0;
  double totalIm = 0;
  loadData() async {

    List<BarChartGroupData> items  = [];
    LocalStorage storage = new LocalStorage('account');
    await storage.ready;
    setState(() {
      imports = [];
      exports = [];
      i=1;
      totalEx = 0;
    });
    Map<String, dynamic> data = await storage.getItem('target1');
    while (i < 20) {
      if(data != null) {
        ImEx ie = ImEx.fromJson(data);
        setState(() {
          totalIm += ie.im.total;
          totalEx += ie.ex.total;
          imports.add(ie.im);
          exports.add(ie.ex);
          items.add(makeGroupData(i-1, ie.im.total, ie.ex.total));
        });
      }
      setState(() {
        i++;
      });
      data = await storage.getItem('target' + i.toString());
    }
    rawBarGroups = items;

    showingBarGroups = rawBarGroups;

    //
    // exports.forEach((element) {
    //   setState(() {
    //     totalEx += element.total;
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor.fromHex(color),
                    HexColor.fromHex('#ffffff'),
                  ],
                )),
            child:Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child:  Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            color: const Color(0xff2c4260),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Tổng thu chi',
                                        style: TextStyle(color: Colors.white, fontSize: 22),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Text(
                                        'đ',
                                        style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                                      ),
                                      Container(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dự tính: ' + totalIm.toString() +'đ',
                                            style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                                          ),
                                          Text(
                                            'Thực tế: ' + totalEx.toString()+ 'đ',
                                            style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 38,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: BarChart(
                                        BarChartData(
                                          maxY: 500000,
                                          barTouchData: BarTouchData(
                                              touchTooltipData: BarTouchTooltipData(
                                                tooltipBgColor: Colors.grey,
                                                getTooltipItem: (_a, _b, _c, _d) => null,
                                              ),
                                              touchCallback: (response) {
                                                if (response.spot == null) {
                                                  setState(() {
                                                    touchedGroupIndex = -1;
                                                    showingBarGroups = List.of(rawBarGroups);
                                                  });
                                                  return;
                                                }

                                                touchedGroupIndex = response.spot.touchedBarGroupIndex;

                                                setState(() {
                                                  if (response.touchInput is PointerExitEvent ||
                                                      response.touchInput is PointerUpEvent) {
                                                    touchedGroupIndex = -1;
                                                    showingBarGroups = List.of(rawBarGroups);
                                                  } else {
                                                    showingBarGroups = List.of(rawBarGroups);
                                                    if (touchedGroupIndex != -1) {
                                                      var sum = 0.0;
                                                      for (var rod in showingBarGroups[touchedGroupIndex].barRods) {
                                                        sum += rod.y;
                                                      }
                                                      final avg =
                                                          sum / showingBarGroups[touchedGroupIndex].barRods.length;

                                                      showingBarGroups[touchedGroupIndex] =
                                                          showingBarGroups[touchedGroupIndex].copyWith(
                                                            barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                                              return rod.copyWith(y: avg);
                                                            }).toList(),
                                                          );
                                                    }
                                                  }
                                                });
                                              }),
                                          titlesData: FlTitlesData(
                                            show: true,
                                            bottomTitles: SideTitles(
                                              showTitles: true,
                                              getTextStyles: (value) => const TextStyle(
                                                  color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                                              margin: 20,
                                              getTitles: (double value) {
                                                    return imports[value.toInt()].name;

                                              },
                                            ),
                                            leftTitles: SideTitles(
                                              showTitles: true,
                                              getTextStyles: (value) => const TextStyle(
                                                  color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                                              margin: 32,
                                              reservedSize: 14,
                                              getTitles: (value) {
                                                if (value == 0) {
                                                  return '1K';
                                                } else if (value == 10000) {
                                                  return '10K';
                                                } else if (value == 100000) {
                                                  return '100K';
                                                }  else if (value == 150000) {
                                                  return '150K';
                                                }  else if (value == 200000) {
                                                  return '200K';
                                                }  else if (value == 300000) {
                                                  return '300K';
                                                }  else if (value == 400000) {
                                                  return '400K';
                                                }  else if (value == 500000) {
                                                  return '500K';
                                                }  else if (value == 50000) {
                                                  return '50K';
                                                } else {
                                                  return '';
                                                }
                                              },
                                            ),
                                          ),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          barGroups: showingBarGroups,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )

                    ],
                  ),



        );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
