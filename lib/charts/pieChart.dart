import 'package:flutter/material.dart';
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

class PieChart extends StatelessWidget {
  List<charts.Series<Chart, String>> _seriesPieData = [];
  PieChart(this._seriesPieData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // SizedBox(
        //   height: 20,
        // ),
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
          child: charts.PieChart(
            _seriesPieData,
            animate: true,
            animationDuration: Duration(seconds: 2),
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
            defaultRenderer: charts.ArcRendererConfig(
              arcWidth: 50,
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
