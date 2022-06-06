import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trading_strategy_tester_app/controller/controller.dart';
import 'package:trading_strategy_tester_app/pages/trade.dart';

class StrategyListPage extends StatelessWidget {
  const StrategyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.put(AllPageController());
    return Obx(() => allPageController.strategyList.isEmpty
        ? Center(
            child: Text(
              "Strategy List is empty.",
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        : const ListDetailStrategyList());
  }
}

class ListDetailStrategyList extends StatelessWidget {
  const ListDetailStrategyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Get.to(TradingPage(index: index)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF343A40),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: InkWell(
                  onTap: () => allPageController.strategyList.removeAt(index),
                  splashColor: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "#${index + 1}",
                        style: Theme.of(context).textTheme.headline2!.merge(
                              const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Icon(
                        Icons.delete_rounded,
                        color: Color(0xFFADB5BD),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Obx(
                      () => Text(
                        allPageController.strategyList[index].strategyName == ""
                            ? "#Strategy Name"
                            : allPageController
                                .strategyList[index].strategyName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Obx(
                      () => Text(
                        allPageController.strategyList[index].durationTrade ==
                                ""
                            ? "#Trade Duration"
                            : allPageController
                                .strategyList[index].durationTrade,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline1!.merge(
                              const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 40,
                  color: Colors.transparent,
                  child: Obx(
                    () => allPageController
                            .strategyList[index].capitalChanges.isEmpty
                        ? Center(
                            child: Text(
                              "No trade yet.",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .merge(const TextStyle(fontSize: 12)),
                            ),
                          )
                        : Obx(
                            () => LineChart(
                              LineChartData(
                                minX: 0,
                                maxX: allPageController.strategyList[index]
                                        .capitalChanges.length -
                                    1,
                                minY: allPageController
                                    .strategyList[index].capitalChanges
                                    .reduce((previousValue, element) =>
                                        previousValue < element
                                            ? previousValue
                                            : element),
                                maxY: allPageController
                                    .strategyList[index].capitalChanges
                                    .reduce((previousValue, element) =>
                                        previousValue > element
                                            ? previousValue
                                            : element),
                                lineBarsData: [
                                  LineChartBarData(
                                    show: true,
                                    gradient: allPageController
                                                    .strategyList[index]
                                                    .capitalChanges[
                                                allPageController
                                                        .strategyList[index]
                                                        .capitalChanges
                                                        .length -
                                                    1] >
                                            allPageController
                                                .strategyList[index]
                                                .capitalChanges[0]
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
                                      gradient: allPageController
                                                      .strategyList[index]
                                                      .capitalChanges[
                                                  allPageController
                                                          .strategyList[index]
                                                          .capitalChanges
                                                          .length -
                                                      1] >
                                              allPageController
                                                  .strategyList[index]
                                                  .capitalChanges[0]
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
                                    barWidth: 2,
                                    dotData: FlDotData(show: false),
                                    isCurved: true,
                                    spots: allPageController
                                        .strategyList[index].flSpotList
                                        .asMap()
                                        .entries
                                        .map((e) {
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
                ),
              ),
              const SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Winrate",
                    style: Theme.of(context).textTheme.headline1!.merge(
                          const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Obx(
                      () => allPageController
                              .strategyList[index].capitalChanges.isEmpty
                          ? Text(
                              "NA%",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .merge(const TextStyle(fontSize: 12)),
                            )
                          : Obx(
                              () => Text(
                                "${(allPageController.strategyList[index].winLosePercentage.where((x) => x > 0).toList().length / allPageController.strategyList[index].winLosePercentage.length * 100).toStringAsFixed(0)}%",
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: (allPageController.strategyList[index]
                                                .winLosePercentage
                                                .where((x) => x > 0)
                                                .toList()
                                                .length /
                                            allPageController
                                                .strategyList[index]
                                                .winLosePercentage
                                                .length *
                                            100) >
                                        50
                                    ? Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                    : Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Gain",
                    style: Theme.of(context).textTheme.headline1!.merge(
                          const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Obx(
                      () => allPageController
                              .strategyList[index].capitalChanges.isEmpty
                          ? Text("NA%",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .merge(const TextStyle(fontSize: 12)))
                          : Obx(
                              () => Text(
                                "${((allPageController.strategyList[index].capitalChanges[allPageController.strategyList[index].capitalChanges.length - 1] - allPageController.strategyList[index].capitalChanges[0]) / allPageController.strategyList[index].capitalChanges[0] * 100).toStringAsFixed(2)}%",
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: ((allPageController.strategyList[index]
                                                        .capitalChanges[
                                                    allPageController
                                                            .strategyList[index]
                                                            .capitalChanges
                                                            .length -
                                                        1] -
                                                allPageController
                                                    .strategyList[index]
                                                    .capitalChanges[0]) /
                                            allPageController
                                                .strategyList[index]
                                                .capitalChanges[0] *
                                            100) <
                                        0
                                    ? Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                    : Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                              ),
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: allPageController.strategyList.length,
      ),
    );
  }
}
