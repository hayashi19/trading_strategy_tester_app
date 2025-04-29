// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

import 'package:trading_strategy_tester_app/controller/ads.dart';
import 'package:trading_strategy_tester_app/controller/controller.dart';
import 'package:trading_strategy_tester_app/pages/trade.dart';

class StrategyList extends StatelessWidget {
  const StrategyList({super.key});

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.put(AllPageController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Strategy List",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder(
              future: controller.getSavedStrategy(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const StrategyList_Listview();
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            ADS(ad: controller.listBanner),
            ElevatedButton.icon(
              onPressed: () {
                controller.addStrategy();
                Get.to(TradingPage(index: controller.strategyList.length - 1));
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text("Add Strategy"),
            ),
          ],
        ),
      ),
    );
  }
}

class StrategyList_Listview extends StatelessWidget {
  const StrategyList_Listview({super.key});

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Expanded(
      child: Obx(
        () {
          return controller.strategyList.isEmpty
              ? Center(
                  child: Text(
                    "No strategy yet",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    itemCount: controller.strategyList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) =>
                        StrategyList_Listview_Detail(index: index),
                  ),
                );
        },
      ),
    );
  }
}

class StrategyList_Listview_Detail extends StatelessWidget {
  int index;
  StrategyList_Listview_Detail({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(TradingPage(index: index)),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xFF343A40),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StrategyList_Listview_Detail_Leading(index: index),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StrategyList_Listview_Detail_Ttitle(index: index),
                  StrategyList_Listview_Detail_Duration(index: index),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: StrategyList_Listview_Detail_Winrate(index: index),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 2,
              child: StrategyList_Listview_Detail_Gain(index: index),
            ),
          ],
        ),
      ),
    );
  }
}

class StrategyList_Listview_Detail_Leading extends StatelessWidget {
  int index;
  StrategyList_Listview_Detail_Leading({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return IconButton(
      onPressed: () => Get.defaultDialog(
        middleText: "Delete ${controller.strategyList[index].strategyTitle}?",
        backgroundColor: const Color(0xFF343A40),
        titleStyle: const TextStyle(color: Colors.red),
        middleTextStyle: const TextStyle(color: Colors.white),
        confirm: InkWell(
          onTap: () {
            controller.deleteStrategy(index);
            Get.back();
          },
          child: Ink(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              "Delete",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
        cancel: InkWell(
          onTap: () {
            Get.back();
          },
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
      iconSize: 24,
      icon: const Icon(Icons.delete_rounded),
    );
  }
}

class StrategyList_Listview_Detail_Ttitle extends StatelessWidget {
  int index;
  StrategyList_Listview_Detail_Ttitle({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Text(
      controller.strategyList[index].strategyTitle,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class StrategyList_Listview_Detail_Duration extends StatelessWidget {
  int index;
  StrategyList_Listview_Detail_Duration({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    controller.getDuration_list(index);
    return Obx(
      () => Text(
        "${controller.duration_list.value} D",
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.displayLarge!.merge(const TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }
}

class StrategyList_Listview_Detail_Winrate extends StatelessWidget {
  int index;
  StrategyList_Listview_Detail_Winrate({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    controller.getWinrate_list(index);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Text(
            controller.winrate_list.value.toString(),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: controller.winrate_list.value > 0
                ? Theme.of(context).textTheme.displaySmall
                : Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "%",
          softWrap: false,
          style: controller.winrate_list.value > 0
              ? Theme.of(context).textTheme.displaySmall
              : Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}

class StrategyList_Listview_Detail_Gain extends StatelessWidget {
  int index;
  StrategyList_Listview_Detail_Gain({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    controller.getGain_list(index);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xFF495057),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          controller.gain_list.value > 0
              ? const Icon(
                  Icons.arrow_drop_up_rounded,
                  size: 20,
                  color: Color(0xFF80FFDB),
                )
              : const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 20,
                  color: Color(0xFFF72585),
                ),
          Expanded(
            child: Text(
              MoneyFormatter(amount: controller.gain_list.value)
                  .output
                  .compactNonSymbol,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: controller.gain_list.value > 0
                  ? Theme.of(context).textTheme.displaySmall
                  : Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "%",
            softWrap: false,
            style: controller.gain_list.value > 0
                ? Theme.of(context).textTheme.displaySmall
                : Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
