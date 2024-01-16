import 'package:active_ecommerce_seller_app/data_model/chart_response.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/shop_repository.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MChart extends StatefulWidget {
  const MChart({super.key});

  @override
  State<MChart> createState() => _MChartState();
}

class _MChartState extends State<MChart> {
  List<ChartResponse> chartList = [];

  List<ChartSeries> _createSampleData() {
    final data = List.generate(chartList.length, (index) {
      return OrdinalSales(chartList[index].date,
          int.parse(chartList[index].total!.round().toString())
          // 56
          );
    });

    return [
      StackedColumnSeries<OrdinalSales, String>(
          // enableTooltip: isTooltipVisible,
          dataSource: data,
          xValueMapper: (OrdinalSales sales, da) => sales.year,
          yValueMapper: (OrdinalSales sales, index) {
            return sales.sales;
          },
          isVisibleInLegend: false,
          color: MyTheme.app_accent_color,
          enableTooltip: true
          //enableAnimation: false,
          // markerSettings: const MarkerSettings(
          //     isVisible: true,
          //     height:  4,
          //     width:  4,
          //     shape: DataMarkerType.circle,
          //     borderWidth: 3,
          //     borderColor: Colors.red),
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true,
          //     //position: ChartDataLabelAlignment.Auto
          // ),
          ),
    ];
  }

  getChart() async {
    var response = await ShopRepository().chartRequest();
    chartList.addAll(response.values);
    setState(() {});
  }

  @override
  void initState() {
    getChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      //title: ChartTitle(text: 'Flutter Chart'),
      legend: Legend(isVisible: true),
      series: _createSampleData(),
      // tooltipBehavior: _tooltipBehavior,
    ));
  }
}

class OrdinalSales {
  final String? year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
