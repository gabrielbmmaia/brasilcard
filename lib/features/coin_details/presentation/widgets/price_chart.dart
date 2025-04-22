import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/utils/formatters.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceChart extends StatelessWidget {
  const PriceChart({required this.data, super.key});

  final List<GraphModel> data;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots =
        data.map((e) => FlSpot(e.time.toDouble(), e.priceUsd)).toList();

    return Container(
      color: context.colorTheme.secondary,
      padding: EdgeInsets.only(top: 16.h),
      height: 250,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => context.colorTheme.tertiary,
              tooltipRoundedRadius: 6.r,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final price = DSFormatter.doubleToDollar(spot.y);
                  final date = DateTime.fromMillisecondsSinceEpoch(
                    spot.x.toInt(),
                  );
                  final formattedDate =
                      "${date.day}/${date.month}/${date.year}";

                  return LineTooltipItem(
                    '$formattedDate\n $price',
                    AppTextStyle.h9.semiBold.copyWith(
                      color: context.colorTheme.primary,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: context.colorTheme.tertiary,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: context.colorTheme.tertiary.withValues(alpha: 0.4),
              ),
              barWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
