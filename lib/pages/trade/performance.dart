// ignore_for_file: camel_case_types, must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

import 'package:trading_strategy_tester_app/controller/controller.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.put(AllPageController());
    return FutureBuilder(
        future: controller.getPerformance_perf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              padding: const EdgeInsets.only(
                left: 10,
                top: 32,
                right: 10,
                bottom: 10,
              ),
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Strategy Performance",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .merge(const TextStyle(fontSize: 14)),
                  ),
                ),
                const SizedBox(height: 10),
                const PerformancePage_FinalCap(),
                const SizedBox(height: 10),
                const PerformancePage_OHLC(),
                const SizedBox(height: 10),
                const PerformancePage_CapitalCurve(),
                const SizedBox(height: 10),
                const PerformancePage_ProfitLoss(),
                const SizedBox(height: 10),
                const PerformancePage_Winrate(),
                const SizedBox(height: 10),
                const PerformanceTrade_Factor(),
                const SizedBox(height: 10),
                const PerformancePage_Max()
              ],
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        });
  }
}

class PerformancePage_FinalCap extends StatelessWidget {
  // int index;
  const PerformancePage_FinalCap({
    super.key,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${MoneyFormatter(amount: controller.finalCap.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                style: controller.finalCap.value > controller.initCap_desc.value
                    ? Theme.of(context).textTheme.displaySmall!.merge(
                        const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                    : Theme.of(context).textTheme.headlineLarge!.merge(
                        const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(
                "Final Capital",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  controller.gain.value > 0
                      ? const Icon(
                          Icons.trending_up_rounded,
                          color: Color(0xFF80FFDB),
                        )
                      : const Icon(
                          Icons.trending_up_rounded,
                          color: Color(0xFFF72585),
                        ),
                  const SizedBox(width: 5),
                  Text(
                    "${(controller.tradingList.isNotEmpty ? MoneyFormatter(amount: controller.gain.value).output.compactNonSymbol : 0)}%",
                    style: controller.gain.value > 0
                        ? Theme.of(context).textTheme.displaySmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))
                        : Theme.of(context).textTheme.headlineLarge!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
              Text(
                "Gain Percentage",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "${MoneyFormatter(amount: controller.totalVolume.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                style: Theme.of(context).textTheme.displayMedium!.merge(
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(
                "Total Volume",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PerformancePage_OHLC extends StatelessWidget {
  // int index;
  const PerformancePage_OHLC({
    super.key,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            controller.tradingPair_trade.value.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .merge(const TextStyle(fontSize: 14)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "o ",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                MoneyFormatter(amount: controller.initCap_desc.value)
                    .output
                    .compactNonSymbol,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 10),
              Text(
                "h ",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                MoneyFormatter(amount: controller.high.value)
                    .output
                    .compactNonSymbol,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 10),
              Text(
                "l ",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                MoneyFormatter(amount: controller.low.value)
                    .output
                    .compactNonSymbol,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 10),
              Text(
                "c ",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                MoneyFormatter(amount: controller.finalCap.value)
                    .output
                    .compactNonSymbol,
                style: controller.finalCap.value > controller.initCap_desc.value
                    ? Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .merge(const TextStyle(fontSize: 14))
                    : Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .merge(const TextStyle(fontSize: 14)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PerformancePage_CapitalCurve extends StatelessWidget {
  const PerformancePage_CapitalCurve({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Capital Curve",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .merge(const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => controller.tradingList.isNotEmpty
                  ? Obx(
                      () => LineChart(
                        // swapAnimationDuration:
                        //     const Duration(milliseconds: 500),
                        LineChartData(
                          minX: 0,
                          maxX: controller.tradingList.length.toDouble(),
                          minY: controller.low.value,
                          maxY: controller.high.value,
                          gridData: FlGridData(
                            show: false,
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          titlesData: FlTitlesData(
                            show: false,
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              dotData: FlDotData(show: false),
                              color: controller.tradingList.last.cap >
                                      controller.initCap_desc.value
                                  ? const Color(0xFF80FFDB)
                                  : const Color(0xFFF72585),
                              isStrokeCapRound: true,
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: controller.initCap_desc.value <
                                        controller.tradingList.last.cap
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0x8080FFDB),
                                          Color(0x1A80FFDB)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color(0x80F72585),
                                          Color(0x1AF72585)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                              ),
                              spots: List.generate(
                                controller.tradingList.length,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  controller.tradingList[index].cap,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Text(
                      "No trade yet",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class PerformancePage_ProfitLoss extends StatelessWidget {
  // int index;
  const PerformancePage_ProfitLoss({
    super.key,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Profit Calculation",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .merge(const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Gross profit",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                "${MoneyFormatter(amount: controller.grossProfit.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .merge(const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Gross loss",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                "${MoneyFormatter(amount: -controller.grossLoss.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .merge(const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total fee (avg ${MoneyFormatter(amount: controller.averageFee.value).output.compactNonSymbol} ${controller.currency_desc.value})",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                "${MoneyFormatter(amount: controller.totalFee.value).output.compactNonSymbol} ${controller.currency_desc}",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .merge(const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(
            height: 16,
            color: Colors.blueGrey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Neto profit",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                "${MoneyFormatter(amount: controller.netoProfit.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                style: controller.netoProfit.value > 0
                    ? Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .merge(const TextStyle(fontWeight: FontWeight.bold))
                    : Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .merge(const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PerformancePage_Winrate extends StatelessWidget {
  // int index;
  const PerformancePage_Winrate({
    super.key,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Win Trade",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                "Profit Factor",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              Text(
                "Lose Trade",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${controller.winrate.value.toStringAsPrecision(4)}%",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                controller.profitFactor.value.toStringAsPrecision(2),
                style: controller.profitFactor.value > 0
                    ? Theme.of(context).textTheme.displaySmall
                    : Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "${(100 - controller.winrate.value).toStringAsPrecision(4)}%",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(height: 5),
          IgnorePointer(
            child: SliderTheme(
              data: SliderThemeData(
                disabledActiveTrackColor: Colors.blue,
                disabledInactiveTrackColor: Colors.black12,
                trackHeight: 3,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                trackShape: const RoundedRectSliderTrackShape(),
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                max: 100,
                min: 1,
                value: controller.winrate.value,
                activeColor: const Color(0xFF80FFDB),
                inactiveColor: const Color(0xFFF72585),
                onChanged: (newValue) {},
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                controller.winTrade.value.toString(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Total Trade ",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .merge(const TextStyle(fontSize: 14)),
                  ),
                  Text(
                    controller.totalTrade.value.toString(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              Text(
                controller.loseTrade.value.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PerformanceTrade_Factor extends StatelessWidget {
  const PerformanceTrade_Factor({super.key});

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Trading Factor",
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .merge(const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 5),
          Table(
            border: TableBorder.all(
              color: const Color(0xFF495057),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            children: <TableRow>[
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Trade Type",
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .merge(const TextStyle(fontSize: 14)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Win",
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .merge(const TextStyle(fontSize: 14)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lose",
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .merge(const TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Cosecutive",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${controller.consecutiveWin.value}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${controller.consecutiveLoss.value}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Largest Nominal",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: controller.largestWinNominal.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: -controller.largestLossNominal.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Largest Percentage",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: controller.largestWinPercentage.value).output.compactNonSymbol}%",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: -controller.largestLossPercentage.value).output.compactNonSymbol}%",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Average Nominal",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: controller.averageWinNominal.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: -controller.averageLossNominal.value).output.compactNonSymbol} ${controller.currency_desc.value}",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Average Percentage",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: controller.averageWinPercentage.value).output.compactNonSymbol}%",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${MoneyFormatter(amount: -controller.averageLossPercentage.value).output.compactNonSymbol}%",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PerformancePage_Max extends StatelessWidget {
  const PerformancePage_Max({super.key});

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Max Posibility",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .merge(const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.trending_down_rounded,
                        color: Color(0xFFF72585),
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${controller.maxDrawdownPercentage.value.toStringAsPrecision(4)}%",
                        style: Theme.of(context).textTheme.headlineLarge!.merge(
                            const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Text(
                    "Max Drawdown",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .merge(const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "${controller.maxRunUpPercentage.value.toStringAsPrecision(4)}%",
                        style: Theme.of(context).textTheme.displaySmall!.merge(
                            const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.trending_up_rounded,
                        color: Color(0xff80ffdb),
                        size: 20,
                      ),
                    ],
                  ),
                  Text(
                    "Max RunUp",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .merge(const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
