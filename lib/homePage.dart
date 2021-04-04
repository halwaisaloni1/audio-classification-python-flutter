import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import './charts/chart.dart';
import './charts/barChart.dart';
import './charts/pieChart.dart';
import './global/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Chart, String>> _seriesBarData = [];
  List<charts.Series<Chart, String>> _seriesPieData = [];
  List<Chart> barChartData = [];
  List<Chart> pieChartData = [];
  List maxValues = [], maxClasses = [], maxClassUrls = [], maxClassNames = [];
  int maxValue;
  String maxClass = '', maxClassName = '', maxClassUrl = '';

  _generateBarChartData(chartData) {
    _seriesBarData = List<charts.Series<Chart, String>>();
    _seriesBarData.add(charts.Series(
      domainFn: (Chart chart, _) => chart.chartClass.toString(), //x-axis value
      measureFn: (Chart chart, _) => chart.chartValue, //y-axis value
      colorFn: (Chart chart, _) => charts.ColorUtil.fromDartColor(
        Color(
          int.parse(chart.color),
        ),
      ),
      id: 'Bar Chart',
      data: chartData,
      labelAccessorFn: (Chart row, _) => "${row.chartClass}",
    ));
  }

  _generatePieChartData(chartData) {
    _seriesPieData = List<charts.Series<Chart, String>>();
    _seriesPieData.add(charts.Series(
      domainFn: (Chart chart, _) => chart.chartClass.toString(), //x-axis value
      measureFn: (Chart chart, _) => chart.chartValue, //y-axis value
      colorFn: (Chart chart, _) => charts.ColorUtil.fromDartColor(
        Color(
          int.parse(chart.color),
        ),
      ),
      id: 'Pie Chart',
      data: chartData,
      labelAccessorFn: (Chart row, _) => "${row.chartValue}",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Urban Sounds',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('Classification').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: LinearProgressIndicator(),
          );
        } else {
          List<Chart> chart = snapshot.data.docs
              .map((documentSnapshot) => Chart.fromMap(documentSnapshot.data()))
              .toList();
          for (int i = 0; i <= snapshot.data.docs.length - 1; i++) {
            maxValues.add(chart[i].toString().substring(7, 9));
            maxClasses.add(chart[i].toString().substring(21, 23));
            maxClassNames.add(chart[i].toString().substring(
                (chart[i].toString().lastIndexOf(':')) + 1,
                (chart[i].toString().length) - 1));
            maxClassUrls.add(chart[i]
                .toString()
                .substring(24, (chart[i].toString().lastIndexOf(':')) - 1));
          }
          maxValue = int.parse(maxValues[0]);
          maxClass = maxClasses[0];
          maxClassName = maxClassNames[0];
          maxClassUrl = maxClassUrls[0];
          for (int i = 0; i < maxValues.length; i++) {
            if (int.parse(maxValues[i]) > maxValue) {
              maxValue = int.parse(maxValues[i]);
              maxClass = maxClasses[i];
              maxClassName = maxClassNames[i];
              maxClassUrl = maxClassUrls[i];
            }
          }
          print(maxValue);
          print(maxClass);
          print(maxClassName);
          print(maxClassUrl);
          return _buildChart(context, chart);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Chart> chart) {
    barChartData = chart;
    _generateBarChartData(barChartData);
    pieChartData = chart;
    _generatePieChartData(pieChartData);
    return Container(
      color: Colors.white,
      // child: Padding(
      //   padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                BarChart(_seriesBarData),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(
                    color: Colors.lightBlue,
                  ),
                ),
                PieChart(_seriesPieData),
                DetailsPage(maxValue, maxClassName, maxClassUrl),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
