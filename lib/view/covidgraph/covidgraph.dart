import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  var data;
  var anotherdata;

  Future getDatas() async {
    String url = 'https://nepalcorona.info/api/v1/data/nepal';

    var response = await http.get(url);
    setState(() {
      anotherdata = json.decode(response.body);
      print(anotherdata);
    });
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  Future<List<TimeLine>> _getData() async {
    String url = 'https://data.nepalcorona.info/api/v1/covid/timeline';

    // var dt = DateTime.parse('2020-10-30');
    // var newDt = DateFormat.yMd().format(dt);
    // print(newDt.replaceAll(new RegExp(r'[^\w\s]+'), ''));

    ///print(newDt);

    var response = await http.get(url);
    data = json.decode(response.body);
    //var hey;
    List<TimeLine> times = [];
    for (var u in data) {
      // hey = DateTime.parse(u["date"]).day;
      // print(hey);
      TimeLine time = TimeLine(
          u["date"],
          u["newCases"],
          u["totalCases"],
          u["totalRecoveries"],
          u["newRecoveries"],
          u["totalDeaths"],
          u["newDeaths"]);
      times.add(time);
    }

    // print(times.length);
    return times;
  }

  @override
  void initState() {
    _getData();
    getDatas();
    super.initState();
  }

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff232d37),
      // appBar: AppBar(
      //   title: Text('Corona Tracker'),
      //   backgroundColor: Colors.blue,
      // ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  padding: EdgeInsets.symmetric(),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    //color: Color(0xff232d37),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: _getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: Text('Loading...'),
                        );
                      } else {
                        return LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(enabled: true),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  for (var i = 40; i < data.length; i++)
                                    FlSpot(
                                        double.parse(snapshot.data[i].date
                                            .toString()
                                            .replaceAll(
                                                new RegExp(r'[^\w\s]+'), '')),
                                        // double.parse(snapshot.data[i].totalRecoveries
                                        //     .toString()
                                        //     .replaceAll(new RegExp(r'[^\w\s]+'), '')),
                                        double.parse(snapshot.data[i].totalCases
                                            .toString()))
                                ],
                                isCurved: true,
                                barWidth: 5,
                                colors: gradientColors,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: false,
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  colors: gradientColors
                                      .map((color) => color.withOpacity(0.3))
                                      .toList(),
                                ),
                              )
                            ],
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 22,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.red),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 20200310:
                                      return 'MAR';
                                    case 20200410:
                                      return 'APR';
                                    case 20200510:
                                      return 'MAY';
                                    case 20200610:
                                      return 'JUN';
                                    case 20200710:
                                      return 'JUL';
                                    case 20200810:
                                      return 'AUG';
                                  }
                                  return '';
                                },
                                margin: 8,
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                textStyle: const TextStyle(
                                  color: Color(0xff67727d),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 5000:
                                      return '5k';
                                    case 10000:
                                      return '10k';
                                    case 15000:
                                      return '15k';
                                    case 20000:
                                      return '20k';
                                    case 25000:
                                      return '25k';
                                    case 30000:
                                      return '30k';
                                    case 35000:
                                      return '35k';
                                  }
                                  return '';
                                },
                                reservedSize: 28,
                                margin: 12,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35.0, 18, 18, 18),
                child: Text(
                  "The graph above shows total cases increase with timeline of months ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 170,
                      width: 120,
                      child: Card(
                        color: Colors.teal,
                        elevation: 10,
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("Cases",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "35,529",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            // Text(anotherdata["tested_positive"].toString()),
                          ],
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 170,
                      width: 120,
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("Recoveries",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text("20,073",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22))),
                          ],
                        ),
                        color: Colors.teal,
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 170,
                      width: 120,
                      child: Card(
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("Deaths",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("183",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                          ],
                        )),
                        color: Colors.teal,
                        elevation: 10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 170,
                      width: 120,
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("Tested Positive",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text("15,273",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22))),
                          ],
                        ),
                        color: Colors.teal,
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class DateFormat {}

class TimeLine {
  final String date;
  final int newCases;
  final int totalCases;
  final int totalRecoveries;
  final int newRecoveries;
  final int totalDeaths;
  final int newDeaths;

  TimeLine(this.date, this.newCases, this.totalCases, this.totalRecoveries,
      this.newRecoveries, this.totalDeaths, this.newDeaths);
}
