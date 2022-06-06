// ignore_for_file: must_be_immutable, unrelated_type_equality_checks, unused_local_variable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:trading_strategy_tester_app/controller/controller.dart';
import 'package:trading_strategy_tester_app/pages/home.dart';

class TradingPage extends StatelessWidget {
  int index;
  TradingPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.put(AllPageController());
    allPageController.onStartPage(index);

    allPageController.loadInterstitialAd();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  CapitalCardTrading(index: index),
                  const SizedBox(height: 10),
                  CapitalChangesTrading(index: index),
                  const SizedBox(height: 10),
                  TimeframeTrading(index: index),
                  const SizedBox(height: 10),
                  ChartHistoryTrading(mainIndex: index),
                  const SizedBox(height: 10),
                  LeverageTrading(index: index),
                  const SizedBox(height: 10),
                  TradeInputTrading(index: index),
                  const SizedBox(height: 10),
                  TradeButtonTrading(index: index),
                  const Divider(
                    height: 32,
                    thickness: 2,
                    color: Color(0xFF495057),
                  ),
                  TradeHistoryTrading(index: index),
                  const Divider(
                    height: 32,
                    thickness: 2,
                    color: Color(0xFF495057),
                  ),
                  WinrateTrading(index: index),
                  const Divider(
                    height: 32,
                    thickness: 2,
                    color: Color(0xFF495057),
                  ),
                  OtherIndicatorTrading(index: index),
                  const Divider(
                    height: 32,
                    thickness: 2,
                    color: Color(0xFF495057),
                  ),
                  IndicatorDescTrading(index: index),
                ],
              ),
            ),
          ),
          ADS(ad: allPageController.tradeBanner)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: deprecated_member_use
          if (index.isNull) {
          } else {
            allPageController.savedStrategy(index);
            if (allPageController.adIsLoaded.value) {
              allPageController.interstitialAd.show();

              print("ADS SHOWN ADS SHOWN ADS SHOWN ADS SHOWN");
            }
            // Get.back();
          }
        },
        child: const Icon(Icons.save_rounded),
      ),
    );
  }
}

class CapitalCardTrading extends StatelessWidget {
  int index;
  CapitalCardTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF7209B7),
            Color(0xFF3A0CA3),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: allPageController.strategyNameController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .merge(const TextStyle(fontWeight: FontWeight.bold)),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration.collapsed(
                    hintText: "# Strategy Name",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline1!
                        .merge(const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: allPageController.durationController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .merge(const TextStyle(fontWeight: FontWeight.bold)),
                  textAlign: TextAlign.end,
                  decoration: InputDecoration.collapsed(
                    hintText: "# Duration",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline1!
                        .merge(const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Initial Capital",
                      style: Theme.of(context).textTheme.headline1!.merge(
                            const TextStyle(fontSize: 16),
                          ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.attach_money_rounded,
                          color: Color(0xFFEDF2FB),
                          size: 16,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller:
                                allPageController.initialCapitalController,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration.collapsed(
                              hintText: "xxxx",
                              hintStyle: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 2,
                      color: Color(0xFFEDF2FB),
                    )
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                "X",
                style: Theme.of(context).textTheme.headline2,
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Budget",
                      style: Theme.of(context).textTheme.headline1!.merge(
                            const TextStyle(fontSize: 16),
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: allPageController.budgetController,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration.collapsed(
                              hintText: "xxx",
                              hintStyle: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "%",
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 2,
                      color: Color(0xFFEDF2FB),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CapitalChangesTrading extends StatelessWidget {
  int index;
  CapitalChangesTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: allPageController.tradingPairController,
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline2!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            textAlign: TextAlign.start,
            decoration: InputDecoration.collapsed(
              hintText: "# Trading Pair",
              hintStyle: Theme.of(context).textTheme.headline1!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "O",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(fontSize: 16)),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "\$${allPageController.initialCapitalController.text}",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .merge(const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "H",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(fontSize: 16)),
            ),
            const SizedBox(
              width: 5,
            ),
            Obx(
              () => allPageController.capitalChangesValue.isEmpty
                  ? Container()
                  : Text(
                      allPageController.capitalChangesValue.isEmpty
                          ? "NA"
                          : "\$${(allPageController.capitalChangesValue.reduce((curr, next) => curr > next ? curr : next)).round()}",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .merge(const TextStyle(fontWeight: FontWeight.bold)),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "L",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(fontSize: 16)),
            ),
            const SizedBox(
              width: 5,
            ),
            Obx(
              () => allPageController.capitalChangesValue.isEmpty
                  ? Container()
                  : Text(
                      allPageController.capitalChangesValue.isEmpty
                          ? "NA"
                          : "\$${(allPageController.capitalChangesValue.reduce((curr, next) => curr < next ? curr : next)).round()}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .merge(const TextStyle(fontWeight: FontWeight.bold)),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "C",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(fontSize: 16)),
            ),
            const SizedBox(
              width: 5,
            ),
            Obx(
              () => allPageController.capitalChangesValue.isEmpty
                  ? Container()
                  : Text(
                      allPageController.capitalChangesValue.isEmpty
                          ? "NA"
                          : "\$${allPageController.capitalChangesValue[allPageController.capitalChangesValue.length - 1].round()}",
                      style: allPageController.capitalChangesValue[
                                  allPageController.capitalChangesValue.length -
                                      1] >
                              double.parse(allPageController
                                  .initialCapitalController.text)
                          ? Theme.of(context).textTheme.headline3!.merge(
                              const TextStyle(fontWeight: FontWeight.bold))
                          : Theme.of(context).textTheme.headline4!.merge(
                              const TextStyle(fontWeight: FontWeight.bold)),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

class TimeframeTrading extends StatelessWidget {
  int index;
  TimeframeTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: allPageController.timeframeList.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: 5,
          ),
          itemBuilder: (context, index) => Obx(
            () => ChoiceChip(
              backgroundColor: const Color(0xFF343A40),
              selectedColor: const Color(0xFF495057),
              shadowColor: const Color(0xFF343A40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              labelStyle: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(fontSize: 16)),
              label: Text(allPageController.timeframeList[index].toString()),
              selected: allPageController.timeframeValue == index,
              onSelected: (bool selected) {
                allPageController.timeframeValue.value = selected ? index : 0;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ChartHistoryTrading extends StatelessWidget {
  int mainIndex;
  ChartHistoryTrading({Key? key, required this.mainIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Obx(
      () => allPageController.tradingBudgetValue.isEmpty
          ? Center(
              child: Text(
                "No trade yet.",
                style: Theme.of(context).textTheme.headline2,
              ),
            )
          : Container(
              color: Colors.transparent,
              height: 100,
              padding: const EdgeInsets.all(0),
              child: Obx(
                () => LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: allPageController.flList.length - 1,
                    minY: allPageController.capitalChangesValue.reduce(
                        (previousValue, element) => previousValue < element
                            ? previousValue
                            : element - 50),
                    maxY: allPageController.capitalChangesValue.reduce(
                        (previousValue, element) => previousValue > element
                            ? previousValue
                            : element + 100),
                    lineBarsData: [
                      LineChartBarData(
                        show: true,
                        gradient: allPageController.capitalChangesValue[
                                    allPageController
                                            .capitalChangesValue.length -
                                        1] >
                                double.parse(allPageController
                                    .initialCapitalController.text)
                            ? const LinearGradient(
                                colors: [
                                  Colors.greenAccent,
                                  Color(0xFF80ffdb),
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  Colors.redAccent,
                                  Color(0xFFf72585),
                                ],
                              ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: allPageController.capitalChangesValue[
                                      allPageController
                                              .capitalChangesValue.length -
                                          1] >
                                  double.parse(allPageController
                                      .initialCapitalController.text)
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x8880ffdb),
                                    Colors.transparent,
                                  ],
                                )
                              : const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x88f72585),
                                    Colors.transparent,
                                  ],
                                ),
                        ),
                        barWidth: 4,
                        dotData: FlDotData(show: false),
                        isCurved: true,
                        spots:
                            allPageController.flList.asMap().entries.map((e) {
                          return FlSpot(e.key.toDouble(), e.value);
                        }).toList(),
                      ),
                    ],
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
    );
  }
}

class TradeHistoryTrading extends StatelessWidget {
  int index;
  TradeHistoryTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Column(
      children: <Widget>[
        Text(
          "Trade History",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .merge(const TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                "#",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Budget",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "%",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "\$",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Fee",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Capital",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        const Divider(
          height: 8,
          color: Colors.blueGrey,
        ),
        SizedBox(
          height: 60,
          child: Obx(
            () => allPageController.tradingBudgetValue.isEmpty
                ? Center(
                    child: Text(
                      "No trade yet",
                      style: Theme.of(context).textTheme.headline2!.merge(
                            const TextStyle(fontSize: 16),
                          ),
                    ),
                  )
                : SingleChildScrollView(
                    reverse: true,
                    child: Obx(
                      () => ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            allPageController.winLosePercentageValue.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "#${index + 1}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .merge(const TextStyle(fontSize: 16)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "\$${allPageController.tradingBudgetValue[index]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .merge(const TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "${allPageController.winLosePercentageValue[index]}%",
                                  overflow: TextOverflow.ellipsis,
                                  style: allPageController
                                              .winLosePercentageValue[index] >
                                          0
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .merge(const TextStyle(fontSize: 16))
                                      : Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .merge(const TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "\$${allPageController.winLoseNominalValue[index]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: allPageController
                                              .winLoseNominalValue[index] >
                                          0
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .merge(const TextStyle(fontSize: 16))
                                      : Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .merge(const TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "\$${allPageController.feePaidValue[index]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .merge(const TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "\$${allPageController.capitalChangesValue[index]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: allPageController
                                              .capitalChangesValue[index] >
                                          0
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .merge(const TextStyle(fontSize: 16))
                                      : Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .merge(const TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class LeverageTrading extends StatelessWidget {
  int index;
  LeverageTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Obx(
            () => Text(
              "Leverage x${allPageController.leverageValue.value}",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(fontSize: 16)),
            ),
          ),
          Obx(
            () => SliderTheme(
              data: SliderThemeData(
                overlayShape: SliderComponentShape.noOverlay,
                trackShape: const RoundedRectSliderTrackShape(),
              ),
              child: Slider(
                value: allPageController.leverageValue.value.toDouble(),
                min: 1,
                max: 200,
                divisions: 200,
                activeColor: allPageController.leverageValue.value < 20
                    ? const Color(0xFF5eafd9)
                    : allPageController.leverageValue.value < 20
                        ? const Color(0xFF449dd1)
                        : allPageController.leverageValue.value < 40
                            ? const Color(0xFF3977bb)
                            : allPageController.leverageValue.value < 60
                                ? const Color(0xFF2d51a5)
                                : allPageController.leverageValue.value < 80
                                    ? const Color(0xFF5c4c8f)
                                    : allPageController.leverageValue.value <
                                            100
                                        ? const Color(0xFF8b4679)
                                        : allPageController
                                                    .leverageValue.value <
                                                160
                                            ? const Color(0xFFc53d4c)
                                            : allPageController
                                                        .leverageValue.value <
                                                    160
                                                ? const Color(0xFFe23836)
                                                : allPageController
                                                            .leverageValue
                                                            .value <
                                                        160
                                                    ? const Color(0xFFff4633)
                                                    : allPageController
                                                                .leverageValue
                                                                .value <
                                                            180
                                                        ? const Color(
                                                            0xFFff5746)
                                                        : const Color.fromARGB(
                                                            255, 255, 206, 70),
                inactiveColor: allPageController.leverageValue.value < 20
                    ? const Color(0xFF5eafd9)
                    : allPageController.leverageValue.value < 20
                        ? const Color(0xFF449dd1)
                        : allPageController.leverageValue.value < 40
                            ? const Color(0xFF3977bb)
                            : allPageController.leverageValue.value < 60
                                ? const Color(0xFF2d51a5)
                                : allPageController.leverageValue.value < 80
                                    ? const Color(0xFF5c4c8f)
                                    : allPageController.leverageValue.value <
                                            100
                                        ? const Color(0xFF8b4679)
                                        : allPageController
                                                    .leverageValue.value <
                                                160
                                            ? const Color(0xFFc53d4c)
                                            : allPageController
                                                        .leverageValue.value <
                                                    160
                                                ? const Color(0xFFe23836)
                                                : allPageController
                                                            .leverageValue
                                                            .value <
                                                        160
                                                    ? const Color(0xFFff4633)
                                                    : allPageController
                                                                .leverageValue
                                                                .value <
                                                            180
                                                        ? const Color(
                                                            0xFFff5746)
                                                        : const Color.fromARGB(
                                                            255, 255, 206, 70),
                thumbColor: const Color(0xFFFFFFFF),
                label:
                    "x${allPageController.leverageValue.value.round().toString()}",
                onChanged: (double newValue) {
                  allPageController.leverageValue.value = newValue.toInt();
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "1",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 16)),
              ),
              Text(
                "200",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 16)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TradeInputTrading extends StatelessWidget {
  int index;
  TradeInputTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final AllPageController allPageController = Get.find();
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Profit Loss Percentage",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                margin: const EdgeInsets.all(0),
                child: TextField(
                    controller: allPageController.percentageChangeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // autofocus: true,
                    style: Theme.of(context).textTheme.headline2,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      hintText: "xxxx",
                      hintStyle: Theme.of(context).textTheme.headline1,
                      suffixText: "%",
                    ),
                    onEditingComplete: () => allPageController.addTrade()),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Fee",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                margin: const EdgeInsets.all(0),
                child: TextField(
                  controller: allPageController.feeController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintText: "xxx",
                    hintStyle: Theme.of(context).textTheme.headline1,
                    suffixText: "%",
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class TradeButtonTrading extends StatelessWidget {
  int index;
  TradeButtonTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: InkWell(
            splashColor: Colors.white,
            onTap: () => allPageController.addTrade(),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0x6603045E), Color(0x66023E8A)],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Obx(
                  () => Text(
                    "${allPageController.winLosePercentageValue.length} ${allPageController.winLosePercentageValue.length > 1 ? "Trades" : "Trade"}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            splashColor: Colors.red,
            onTap: () => allPageController.removeTradePrevious(),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0x667400B8), Color(0x66B5179E)],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "Delete Previous Trade",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WinrateTrading extends StatelessWidget {
  int index;
  WinrateTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Obx(
              () => Text(
                "${(allPageController.winLosePercentageValue.where((x) => x < 0).toList().length / allPageController.winLosePercentageValue.length * 100).toStringAsFixed(2)}%",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Text(
              "Winrate",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .merge(const TextStyle(fontSize: 16)),
            ),
            Obx(
              () => Text(
                "${(allPageController.winLosePercentageValue.where((x) => x > 0).toList().length / allPageController.winLosePercentageValue.length * 100).toStringAsFixed(2)}%",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ],
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        // Container(
        //   height: 5,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(100)),
        //     gradient: LinearGradient(
        //       stops: [
        //         (78 / 100) - 0.01,
        //         (21 / 100) + 0.01,
        //       ],
        //       colors: [Color(0xFFF72585), Color(0xFF80FFDB)],
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 5,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Lose Trade",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .merge(const TextStyle(fontSize: 16)),
                ),
                Obx(
                  () => Text(
                    allPageController.winLosePercentageValue
                        .where((x) => x < 0)
                        .toList()
                        .length
                        .toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Total Trade",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .merge(const TextStyle(fontSize: 16)),
                ),
                Obx(
                  () => Text(
                    allPageController.winLosePercentageValue.length.toString(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Win Trade",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .merge(const TextStyle(fontSize: 16)),
                ),
                Obx(
                  () => Text(
                    allPageController.winLosePercentageValue
                        .where((x) => x > 0)
                        .toList()
                        .length
                        .toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class OtherIndicatorTrading extends StatelessWidget {
  int index;
  OtherIndicatorTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        "Gross Loss",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => allPageController.winLoseNominalValue.isEmpty
                            ? Text(
                                "NA",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            : Text(
                                "\$${allPageController.foldLeft(allPageController.winLoseNominalValue, 0, (val, entry) => entry < 0 ? val + entry : val).toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        "Average Loss",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => allPageController.winLoseNominalValue.isEmpty
                            ? Text(
                                "NA",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            : Text(
                                "${(allPageController.foldLeft(allPageController.winLosePercentageValue, 0, (val, entry) => entry < 0 ? val + entry : val) / allPageController.winLosePercentageValue.where((x) => x < 0).toList().length).toStringAsFixed(2)}%",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        "Largest Loss Trade",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => allPageController.winLoseNominalValue.isEmpty
                            ? Text(
                                "NA",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            : Text(
                                "\$${(allPageController.winLoseNominalValue.reduce((curr, next) => curr < next ? curr : next)).toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Color(0xFF495057),
            thickness: 2,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        "Gross Win",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => allPageController.winLoseNominalValue.isEmpty
                            ? Text(
                                "NA",
                                style: Theme.of(context).textTheme.headline3,
                              )
                            : Text(
                                "\$${allPageController.foldLeft(allPageController.winLoseNominalValue, 0, (val, entry) => entry > 0 ? val + entry : val).toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        "Average Win",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => allPageController.winLosePercentageValue.isEmpty
                            ? Text(
                                "NA",
                                style: Theme.of(context).textTheme.headline3,
                              )
                            : Text(
                                "${(allPageController.foldLeft(allPageController.winLosePercentageValue, 0, (val, entry) => entry > 0 ? val + entry : val) / allPageController.winLosePercentageValue.where((x) => x > 0).toList().length).toStringAsFixed(2)}%",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        "Largest Win Trade",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => allPageController.winLoseNominalValue.isEmpty
                            ? Text(
                                "NA",
                                style: Theme.of(context).textTheme.headline3,
                              )
                            : Text(
                                "\$${(allPageController.winLoseNominalValue.reduce((curr, next) => curr > next ? curr : next)).toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorDescTrading extends StatelessWidget {
  int index;
  IndicatorDescTrading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Indicator Desc",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .merge(const TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          height: 5,
        ),
        Card(
          margin: const EdgeInsets.all(0),
          child: TextField(
            controller: allPageController.indicatorDescController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: Theme.of(context).textTheme.headline2,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              hintText: "describe your trading indicator . . .",
              hintStyle: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ],
    );
  }
}
