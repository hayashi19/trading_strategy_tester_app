// ignore_for_file: camel_case_types, must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:tiny_charts/tiny_charts.dart';
import 'package:trading_strategy_tester_app/controller/controller.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AllPageController());
    return ListView(
      padding: const EdgeInsets.only(
        left: 10,
        top: 0,
        right: 10,
        bottom: 10,
      ),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 10,
            top: 32,
            right: 10,
            bottom: 10,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF343A40),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TradePage_TradeSetting(),
              SizedBox(height: 14),
              TradePage_Budget(),
              Divider(
                height: 24,
                color: Color(0xFFADB5BD),
              ),
              TradePage_TradePercentage(),
              SizedBox(height: 10),
              TradePage_Confirmation(),
              SizedBox(height: 10),
              TradePage_TradeButton(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const TradePage_History()
      ],
    );
  }
}

class TradePage_TradeSetting extends StatelessWidget {
  const TradePage_TradeSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.getToggleCapitalCurve(),
                child: Ink(
                  padding: const EdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.candlestick_chart_rounded,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            const TradePage_CapitalCurve(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.bottomSheet(
                  const TradePage_TradeSetting_Timeframe(),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(5.0),
                  child: Obx(
                    () => Text(
                      controller.timeframeValue_trade.value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.merge(
                            const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.bottomSheet(
                  const TradePage_TradeSetting_Fee(),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(5.0),
                  child: Obx(
                    () => Text(
                      (controller.feeTypeValue_trade.value == '%')
                          ? "${controller.feePercentage_trade.value}%"
                          : "${controller.feeNominal_trade.value} ${controller.currency_desc.value}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.merge(
                            const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.bottomSheet(
                  const TradePage_TradeSetting_Leverage(),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(5.0),
                  child: Obx(
                    () => Text(
                      "x${controller.leverage_trade.value.round()}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.merge(
                            const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.bottomSheet(
                  const TradePage_TradeSetting_TradingPair(),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(5.0),
                  child: Obx(
                    () => Text(
                      controller.tradingPair_trade.value.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.merge(
                            const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TradePage_TradeSetting_Timeframe extends StatelessWidget {
  const TradePage_TradeSetting_Timeframe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      height: 132,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF212529),
      child: FutureBuilder(
        future: controller.getTimeframe_trade(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Choose Timeframe",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF343A40),
                            Color(0xFF212529),
                          ],
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => ToggleButtons(
                            borderWidth: 0,
                            borderColor: Colors.transparent,
                            color: const Color(0xFFADB5BD),
                            selectedColor: const Color(0xFFEDF2FB),
                            onPressed: (int index) =>
                                controller.setTimeframe_trade(index),
                            isSelected: controller.timeframeIsSelected_trade,
                            children: controller.timeframeWidget_trade,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class TradePage_TradeSetting_Fee extends StatelessWidget {
  const TradePage_TradeSetting_Fee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      height: 164,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF212529),
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Edit Info",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .merge(const TextStyle(fontSize: 14)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF343A40),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: controller.feeController_trade,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration.collapsed(
                          hintText: "type your fee",
                          hintStyle: Theme.of(context).textTheme.displayLarge,
                        ),
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF495057),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      width: 50,
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton<String>(
                            value: controller.feeTypeValue_trade.value,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Color(0xFFADB5BD),
                            ),
                            elevation: 16,
                            isExpanded: true,
                            iconSize: 32,
                            isDense: true,
                            onChanged: (String? newValue) {
                              controller.feeTypeValue_trade.value = newValue!;
                            },
                            items: controller.feeTypeList_trade
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: Theme.of(context).textTheme.displayMedium,
                            dropdownColor: const Color(0xFF343A40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF495057),
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    const Color(0xFFEDF2FB),
                  ),
                ),
                onPressed: () {
                  controller.setTrading_trade();
                  Get.back();
                },
                icon: const Icon(Icons.mode_edit_outline_rounded),
                label: const Text("Confirm"),
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.close_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TradePage_TradeSetting_Leverage extends StatelessWidget {
  const TradePage_TradeSetting_Leverage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      height: 216,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF212529),
      child: FutureBuilder(
          future: controller.getLeverage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Set Leverage",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF343A40),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (controller.leverageTemp_trade.value > 1) {
                                    controller.leverageTemp_trade.value--;
                                    controller.leverageController_trade.text =
                                        controller.leverageTemp_trade.value
                                            .round()
                                            .toString();
                                  }
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Icon(
                                      Icons.exposure_minus_1_rounded),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: controller.leverageController_trade,
                                keyboardType: TextInputType.number,
                                onChanged: (newValue) {
                                  double newValueTemp =
                                      double.tryParse(newValue) ?? 0.0;
                                  if (newValueTemp >= 1 &&
                                      newValueTemp <= 300) {
                                    controller.leverageTemp_trade.value =
                                        newValueTemp;
                                  }
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: "leverage x",
                                  hintStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (controller.leverageTemp_trade.value <
                                      300) {
                                    controller.leverageTemp_trade.value++;
                                    controller.leverageController_trade.text =
                                        controller.leverageTemp_trade.value
                                            .round()
                                            .toString();
                                  }
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Icon(Icons.plus_one_rounded),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xFF495057),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            const Color(0xFFEDF2FB),
                          ),
                        ),
                        onPressed: () => {
                          controller.setTrading_trade().then((value) {
                            Get.back();
                          })
                        },
                        icon: const Icon(Icons.mode_edit_outline_rounded),
                        label: const Text("Confirm"),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class TradePage_TradeSetting_TradingPair extends StatelessWidget {
  const TradePage_TradeSetting_TradingPair({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      height: 164,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF212529),
      child: FutureBuilder(
          future: controller.getTradingPair_trade(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Trading Pair",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF343A40),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextField(
                          controller: controller.tradingPairController_trade,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration.collapsed(
                            hintText: "type your budget",
                            hintStyle: Theme.of(context).textTheme.displayLarge,
                          ),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFF495057)),
                          foregroundColor:
                              WidgetStateProperty.all(const Color(0xFFEDF2FB)),
                        ),
                        onPressed: () => controller.setTradingPair_trade(),
                        icon: const Icon(Icons.mode_edit_outline_rounded),
                        label: const Text("Confirm"),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class TradePage_CapitalCurve extends StatelessWidget {
  const TradePage_CapitalCurve({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Obx(
      () => Visibility(
        visible: controller.toggleCapitalCurve_trade.value,
        child: Container(
          height: 30,
          width: 60,
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Color(0xFF495057),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Obx(
            () => TinyLineChart(
              options: TinyLineChartOptions(
                color: controller.tradingList.last.cap >
                        controller.tradingList.first.cap
                    ? const Color(0xFF80FFDB)
                    : const Color(0xFFF72585),
                lineWidth: 2,
              ),
              dataPoints: List<Offset>.generate(
                controller.tradingList.length,
                (i) => Offset(i.toDouble(), controller.tradingList[i].cap),
                growable: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TradePage_Budget extends StatelessWidget {
  const TradePage_Budget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF495057),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          width: 50,
          child: DropdownButtonHideUnderline(
            child: Obx(
              () => DropdownButton<String>(
                value: controller.budgetTypeValue_trade.value,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Color(0xFFADB5BD),
                ),
                elevation: 16,
                isExpanded: true,
                iconSize: 32,
                isDense: true,
                onChanged: (String? newValue) {
                  controller.budgetTypeValue_trade.value = newValue!;
                  controller.setTrading_trade();
                },
                items: controller.budgetTypeList_trade
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                style: Theme.of(context).textTheme.displayMedium,
                dropdownColor: const Color(0xFF343A40),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller.budgetController_trade,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration.collapsed(
              hintText: "type your budget",
              hintStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
              ),
            ),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 24,
            ),
            onChanged: (newValue) {
              if ((controller.budgetTypeValue_trade.contains('%')) &&
                  ((double.tryParse(newValue) ?? 0.0) > 100)) {
                controller.budgetController_trade.text = "100";
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Budget cannot greater than 100%"),
                  ),
                );
              }
              controller.setTrading_trade();
              // controller.getTrading_trade();
            },
          ),
        ),
      ],
    );
  }
}

class TradePage_TradePercentage extends StatelessWidget {
  const TradePage_TradePercentage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF495057),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          width: 50,
          child: DropdownButtonHideUnderline(
            child: Obx(
              () => DropdownButton<String>(
                value: controller.tradeTypeValue_trade.value,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Color(0xFFADB5BD),
                ),
                elevation: 16,
                isExpanded: true,
                iconSize: 32,
                isDense: true,
                onChanged: (String? newValue) {
                  controller.tradeTypeValue_trade.value = newValue!;
                  controller.setTrading_trade();
                },
                items: controller.tradeTypeList_trade
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                style: Theme.of(context).textTheme.displayMedium,
                dropdownColor: const Color(0xFF343A40),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller.tradePercentageController_trade,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration.collapsed(
              hintText: "profit or loss trade amount",
              hintStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .merge(const TextStyle(fontSize: 14)),
            ),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displayMedium!.merge(
                  const TextStyle(
                    fontSize: 24,
                  ),
                ),
            onChanged: (newValue) {
              controller.setTrading_trade();
            },
            onEditingComplete: () {
              controller.setTrading_trade();
              controller.addTrade();
            },
          ),
        ),
      ],
    );
  }
}

class TradePage_Confirmation extends StatelessWidget {
  const TradePage_Confirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Obx(
      () => Text(
        "Budget with leverage ${MoneyFormatter(amount: controller.budget_trade.value).output.compactNonSymbol} ${controller.currency_desc.value}, profit / loss ${MoneyFormatter(amount: controller.tradeNominal_trade.value).output.compactNonSymbol} ${controller.currency_desc.value}, percentage ${controller.tradePercentage_trade.value}%, fee nominal ${MoneyFormatter(amount: controller.feeNominal_trade.value).output.compactNonSymbol} ${controller.currency_desc.value}, percentage ${controller.feePercentage_trade}%, changes ${MoneyFormatter(amount: controller.changes_trade.value).output.compactNonSymbol} ${controller.currency_desc.value}, capital ${MoneyFormatter(amount: controller.cap_trade.value).output.compactNonSymbol} ${controller.currency_desc.value}",
        textAlign: TextAlign.justify,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .merge(const TextStyle(fontSize: 10)),
      ),
    );
  }
}

class TradePage_TradeButton extends StatelessWidget {
  const TradePage_TradeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color(0xFF495057)),
              foregroundColor: WidgetStateProperty.all(const Color(0xFFEDF2FB)),
            ),
            onPressed: () {
              controller.setTrading_trade();
              controller.addTrade();
            },
            child: Obx(
              () => Text("Add #${controller.tradingList.length + 1} Trade"),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(
                const Color(0xFFEDF2FB),
              ),
            ),
            onPressed: () => controller.deleteTrade(),
            child: const Text("Delete Prev Trade"),
          ),
        ),
      ],
    );
  }
}

class TradePage_History extends StatelessWidget {
  const TradePage_History({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "Trade History",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .merge(const TextStyle(fontSize: 14)),
        ),
        const SizedBox(height: 10),
        Obx(
          () => controller.tradingList.isEmpty
              ? Center(
                  child: Text(
                    "No trade yet",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingTextStyle: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .merge(const TextStyle(fontSize: 14)),
                    columns: const [
                      DataColumn(
                        label: Text(
                          "Budget",
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Trade Profit/Loss",
                        ),
                      ),
                      DataColumn(
                        label: Text("Fee"),
                      ),
                      DataColumn(
                        label: Text("Leverage"),
                      ),
                      DataColumn(
                        label: Text(
                          "Changes",
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Capital",
                        ),
                      ),
                    ],
                    rows: controller.tradingList
                        .map(
                          (element) => DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    Text(
                                      "${MoneyFormatter(amount: element.budget).output.compactNonSymbol} ${controller.currency_desc.value}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF343A40),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        "${element.budgetPerccentage.toStringAsFixed(2)}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .merge(
                                                const TextStyle(fontSize: 12)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    Text(
                                      "${MoneyFormatter(amount: element.tradeNominal).output.compactNonSymbol} ${controller.currency_desc.value}",
                                      style: element.tradeNominal > 0
                                          ? Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                          : Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF343A40),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          element.tradeNominal > 0
                                              ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Color(0xFF80FFDB),
                                                )
                                              : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Color(0xFFF72585),
                                                ),
                                          Text(
                                            "${element.tradePercentage.toStringAsFixed(2)}%",
                                            style: element.tradePercentage > 0
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .merge(const TextStyle(
                                                        fontSize: 12))
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .merge(const TextStyle(
                                                        fontSize: 12)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    Text(
                                      "${MoneyFormatter(amount: element.feeNominal).output.compactNonSymbol} ${controller.currency_desc.value}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF343A40),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text(
                                        "- ${element.feePercentage.toStringAsFixed(2)}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .merge(
                                                const TextStyle(fontSize: 12)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              DataCell(
                                Text(
                                  "x${element.leverage}",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${MoneyFormatter(amount: element.changes).output.compactNonSymbol} ${controller.currency_desc}",
                                  style: element.changes > 0
                                      ? Theme.of(context).textTheme.displaySmall
                                      : Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${MoneyFormatter(amount: element.cap).output.compactNonSymbol} ${controller.currency_desc}",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ],
    );
  }
}
