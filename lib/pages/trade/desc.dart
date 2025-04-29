// ignore_for_file: must_be_immutable, camel_case_types, depend_on_referenced_packages

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:intl/intl.dart';

import 'package:trading_strategy_tester_app/controller/controller.dart';

class DescPage extends StatelessWidget {
  const DescPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 10,
        top: 32,
        right: 10,
        bottom: 10,
      ),
      children: const <Widget>[
        DescPage_CapitalInfo(),
        SizedBox(height: 10),
        DescPage_Date(),
        SizedBox(height: 10),
        DescPage_IndicatorList()
      ],
    );
  }
}

class DescPage_CapitalInfo extends StatelessWidget {
  const DescPage_CapitalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // strategy title
          SizedBox(
            width: 300,
            child: Obx(
              () => Text(
                controller.title_desc.value.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // init cap title
          Text(
            "Initial Cap",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .merge(const TextStyle(fontSize: 14)),
          ),
          // init cap value
          Obx(
            () => Text(
              "${MoneyFormatter(amount: controller.initCap_desc.value).output.compactNonSymbol} ${controller.currency_desc.value}",
              style: Theme.of(context).textTheme.displayMedium!.merge(
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          // init cap edit button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.bottomSheet(
                const DescPage_CapitalInfo_EditPage(),
              ),
              child: Ink(
                width: 140,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF495057),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.mode_edit_outline_rounded,
                      color: Color(0xFFADB5BD),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Capital Info",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .merge(const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DescPage_CapitalInfo_EditPage extends StatelessWidget {
  const DescPage_CapitalInfo_EditPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      height: 224,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF212529),
      child: FutureBuilder(
          future: controller.getCapitalInfo_deesc(),
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    // edit capital info title
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
                    // title textfield
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF343A40),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextField(
                        controller: controller.strategyTitleController_trade,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: "Strategy Title",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // init cap textfield
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF343A40),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controller.initCapController_trade,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.displayMedium,
                              decoration: InputDecoration.collapsed(
                                hintText: "Initial Cap",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .merge(const TextStyle(fontSize: 14)),
                              ),
                            ),
                          ),
                          // currency dropdown box
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                theme: CurrencyPickerThemeData(
                                  backgroundColor: const Color(0xFF212529),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  subtitleTextStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                onSelect: (Currency currency) {
                                  controller.currencyTemp_desc.value =
                                      currency.code;
                                },
                              ),
                              child: Ink(
                                padding: const EdgeInsets.all(4.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF495057),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Obx(
                                      () => Text(
                                        controller.currencyTemp_desc.value
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .merge(
                                                const TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.currency_exchange_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // save cap info button
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF495057)),
                        foregroundColor:
                            WidgetStateProperty.all(const Color(0xFFEDF2FB)),
                      ),
                      onPressed: () {
                        controller.saveCapitalInfo_desc();
                        // controller.getTrading_trade();
                        Get.back();
                      },
                      icon: const Icon(Icons.mode_edit_outline_rounded),
                      label: const Text("Confirm"),
                    )
                  ],
                ),
                // close buttons
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
          }),
    );
  }
}

class DescPage_Date extends StatelessWidget {
  const DescPage_Date({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // duration title
          Text(
            "Date Range [start - end]",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .merge(const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 10),
          // duration button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // start date button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.getDuration_desc(context),
                  child: Ink(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF495057),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.edit_calendar_rounded),
                        const SizedBox(width: 5),
                        Obx(
                          () => Text(
                            DateFormat.yMMMMd('en_US')
                                .format(controller.duration_trade.value.start),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .merge(const TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_right_alt_rounded,
                size: 32,
              ),
              // end date button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.getDuration_desc(context),
                  child: Ink(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF495057),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.edit_calendar_rounded),
                        const SizedBox(width: 5),
                        Obx(
                          () => Text(
                            DateFormat.yMMMMd('en_US')
                                .format(controller.duration_trade.value.end),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .merge(const TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // duration desc
          Align(
            alignment: Alignment.center,
            child: Obx(
              () => Text(
                "Duration ${controller.duration_trade.value.duration.inDays} D",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DescPage_IndicatorList extends StatelessWidget {
  const DescPage_IndicatorList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF343A40),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          //indicator displaySmallr
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // indicator title
              Text(
                "Indicator List",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .merge(const TextStyle(fontSize: 14)),
              ),
              // add indicator button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      DescPage_IndicatorList_EditPage(
                        isEdit: false,
                        index: 0,
                      ),
                    );
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF495057),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.add_box_rounded),
                        const SizedBox(width: 5),
                        Text(
                          "Add",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // indicator list
          Obx(
            () => controller.strategyIndicatorList.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.strategyIndicatorList.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Color(0xFFADB5BD),
                      height: 16,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.bottomSheet(
                            DescPage_IndicatorList_EditPage(
                              isEdit: true,
                              index: index,
                            ),
                          );
                        },
                        // indicator name
                        leading: Text(
                          "#${index + 1}",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        // indicator desc
                        title: Text(
                          controller.strategyIndicatorList[index].indicatorName
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        subtitle: Text(
                          controller.strategyIndicatorList[index].indicatorDesc,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                        // delete button
                        trailing: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () =>
                                controller.deleteStrategyIndicator_desc(index),
                            child: Ink(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF495057),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Color(0xFFADB5BD),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No indicator yet",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class DescPage_IndicatorList_EditPage extends StatelessWidget {
  int index;
  bool isEdit;
  DescPage_IndicatorList_EditPage({
    super.key,
    required this.isEdit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.find();
    return Container(
      height: 224,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF212529),
      child: FutureBuilder(
          future: controller.getStrategyIndicator_desc(index, isEdit),
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    // edit inidicator title
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Add Indicator",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .merge(const TextStyle(fontSize: 14)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // indicator name textfield
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF343A40),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextField(
                        controller: controller.indicatorNameController_trade,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: "indicator name",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // indicator desc textfield
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF343A40),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextField(
                        controller: controller.indicatorDescController_trade,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: "how to use the indicator . . .",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .merge(const TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // save indicator button
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF495057)),
                        foregroundColor:
                            WidgetStateProperty.all(const Color(0xFFEDF2FB)),
                      ),
                      onPressed: () => isEdit
                          ? controller.saveEditStrategyIndicator_desc(index)
                          : controller.addStrategyIndicator_desc(),
                      icon: Icon(
                        isEdit
                            ? Icons.edit_note_rounded
                            : Icons.add_chart_rounded,
                      ),
                      label: Text(
                        isEdit ? "Edit" : "Add",
                      ),
                    )
                  ],
                ),
                // close button
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
          }),
    );
  }
}
