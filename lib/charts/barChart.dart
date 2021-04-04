import 'package:flutter/material.dart';
import '../global/shader.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chart.dart';

class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;

  IconRenderer(this.iconData);

  @override
  Widget build(
    BuildContext context, {
    Size size,
    Color color,
    bool enabled,
  }) {
    return new SizedBox.fromSize(
      size: size,
      child: new Icon(
        iconData,
        color: color,
        size: 20.0,
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  List<charts.Series<Chart, String>> _seriesBarData = [];
  BarChart(this._seriesBarData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          'Classification Reports',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient,
            fontFamily: 'Georgia',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 370,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(
            //   color: Colors.blueGrey[200],
            //   width: 1,
            //   style: BorderStyle.solid,
            // ),
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 5,
            //     spreadRadius: 5,
            //     offset: Offset(10, 5),
            //   ),
            // ],
          ),
          child: charts.BarChart(
            _seriesBarData,
            // animate: true,
            defaultRenderer: charts.BarRendererConfig(
                symbolRenderer: IconRenderer(Icons.audiotrack_rounded)),
            // animationDuration: Duration(seconds: 2),
            domainAxis: charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelRotation: 60,
              ),
              showAxisLine: true,
            ),
            behaviors: [
              charts.DatumLegend(
                position: charts.BehaviorPosition.top,
                desiredMaxColumns: 6,
                // horizontalFirst: false,
                entryTextStyle: charts.TextStyleSpec(
                  color: charts.MaterialPalette.indigo.shadeDefault,
                  fontFamily: 'Georgia',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
