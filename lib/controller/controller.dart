// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:list_ext/list_ext.dart';

import 'package:trading_strategy_tester_app/controller/list_model.dart';

class AllPageController extends GetxController {
  // STRATEGY LIST PAGE /////////////////////////////////////////////////////////////////////////////////////////
  var strategyList = <StrategyListModel>[].obs;
  var duration_list = "0".obs;
  var winrate_list = 0.0.obs;
  var gain_list = 0.0.obs;

  Future<void> addStrategy() async {
    try {
      Future<void>.sync(() => strategyList.add(
            StrategyListModel(
              strategyTitle: "Title",
              startDate: DateTime.now().toString(),
              endDate: DateTime.now().toString(),
              initCap: 100,
              currency: "USD",
              timeframe: "1m",
              tradingPair: "BTCUSD",
              indicator: <IndicatorListModel>[],
              trade: <TradingListModel>[],
              // indicatorName: [],
              // indicatorDesc: [],
              // tradePercentage: [],
              // tradeNominal: [],
              // feePercentage: [],
              // feeNominal: [],
              // leverage: [],
              // changes: [],
              // cap: [],
              // budget: [],
              // budgetPercentage: [],
            ),
          ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteStrategy(int index) async {
    try {
      Future<void>.sync(() => strategyList.removeAt(index));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getDuration_list(int index) async {
    try {
      duration_list.value = DateTime.parse(strategyList[index].endDate)
          .difference(DateTime.parse(strategyList[index].startDate))
          .inDays
          .toString();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getWinrate_list(int index) async {
    try {
      winrate_list.value = (strategyList[index]
                  .trade
                  .where((element) => element.tradePercentage > 0)
                  .length /
              strategyList[index].trade.length) *
          100;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getGain_list(int index) async {
    try {
      gain_list.value = (strategyList[index].trade.isNotEmpty)
          ? (strategyList[index].trade.last.cap - strategyList[index].initCap) /
              strategyList[index].initCap *
              100
          : 0;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // STRATEGY LIST PAGE /////////////////////////////////////////////////////////////////////////////////////////

  // TRADING PAGE /////////////////////////////////////////////////////////////////////////////////////////
  Future<void> getStrategy_trade(int index) async {
    try {
      loadInterstitialAd();
      title_desc.value = strategyList[index].strategyTitle;
      initCap_desc.value = strategyList[index].initCap;
      currency_desc.value = strategyList[index].currency;
      duration_trade.value = DateTimeRange(
        start: DateTime.parse(strategyList[index].startDate),
        end: DateTime.parse(strategyList[index].endDate),
      );
      tradingPair_trade.value = strategyList[index].tradingPair;
      strategyIndicatorList.value = strategyList[index].indicator;
      tradingList.value = strategyList[index].trade;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveTradingStrategy_trade(int index) async {
    try {
      strategyList[index] = StrategyListModel(
        strategyTitle: title_desc.value,
        startDate: duration_trade.value.start.toString(),
        endDate: duration_trade.value.end.toString(),
        initCap: initCap_desc.value,
        currency: currency_desc.value,
        timeframe: timeframeValue_trade.value,
        tradingPair: tradingPair_trade.value,
        indicator: strategyIndicatorList.value,
        trade: tradingList.value,
      );
      budgetController_trade.clear();
      tradePercentageController_trade.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // TRADING PAGE /////////////////////////////////////////////////////////////////////////////////////////

  // DESC PAGE /////////////////////////////////////////////////////////////////////////////////////////
  var title_desc = "#Title".obs;
  var initCap_desc = 100.0.obs;
  var currency_desc = "USD".obs;
  var currencyTemp_desc = "USD".obs;

  TextEditingController strategyTitleController_trade = TextEditingController();
  TextEditingController initCapController_trade = TextEditingController();

  var duration_trade = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  ).obs;

  Future<void> getDuration_desc(BuildContext context) async {
    Future<DateTimeRange>.sync(() async => await (showDateRangePicker(
          context: context,
          helpText: "Set your trade start and end date",
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colors.greenAccent,
                  onPrimary: Color(0xFFEDF2FB),
                  onSurface: Color(0xFFEDF2FB),
                ),
                dialogBackgroundColor: const Color(0xFF343A40),
              ),
              child: child!,
            );
          },
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          currentDate: DateTime.now(),
        )).then(
          (value) => duration_trade.value = value ??
              DateTimeRange(
                start: DateTime(1900),
                end: DateTime(2100),
              ),
        ));
  }

  var strategyIndicatorList = <IndicatorListModel>[].obs;
  TextEditingController indicatorNameController_trade = TextEditingController();
  TextEditingController indicatorDescController_trade = TextEditingController();

  Future<void> getCapitalInfo_deesc() async {
    try {
      strategyTitleController_trade.text = title_desc.value;
      initCapController_trade.text = initCap_desc.value.toString();
      currencyTemp_desc.value = currency_desc.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveCapitalInfo_desc() async {
    try {
      await Future<double>.sync(() {
        title_desc.value = strategyTitleController_trade.text;
        initCap_desc.value =
            double.tryParse(initCapController_trade.text) ?? 0.0;
        currency_desc.value = currencyTemp_desc.value;
        return initCap_desc.value;
      }).then((value) async {
        if (tradingList.isNotEmpty) {
          await Future.sync(() {
            for (var i = 0; i < tradingList.length; i++) {
              double budget = (tradingList[i].budgetPerccentage / 100) *
                  tradingList[i].leverage *
                  initCap_desc.value;
              double getProfitLoss =
                  budget * (tradingList[i].tradePercentage / 100);
              double fee = budget * (tradingList[i].feePercentage / 100);
              double changes = getProfitLoss + fee;
              double cap = i < 1
                  ? getProfitLoss + value
                  : getProfitLoss + tradingList[i - 1].cap;
              tradingList[i] = TradingListModel(
                tradePercentage: tradingList[i].tradePercentage,
                tradeNominal: getProfitLoss,
                feePercentage: tradingList[i].feePercentage,
                feeNominal: fee,
                leverage: tradingList[i].leverage,
                changes: changes,
                cap: cap,
                budget: budget,
                budgetPerccentage: tradingList[i].budgetPerccentage,
              );
            }
          });
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addStrategyIndicator_desc() async {
    try {
      strategyIndicatorList.add(
        IndicatorListModel(
          indicatorName: indicatorNameController_trade.text,
          indicatorDesc: indicatorDescController_trade.text,
        ),
      );
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteStrategyIndicator_desc(int index) async {
    try {
      strategyIndicatorList.removeAt(index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStrategyIndicator_desc(int index, bool isEdit) async {
    try {
      if (isEdit) {
        indicatorNameController_trade.text =
            strategyIndicatorList[index].indicatorName;
        indicatorDescController_trade.text =
            strategyIndicatorList[index].indicatorDesc;
      } else {
        indicatorNameController_trade.clear();
        indicatorDescController_trade.clear();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveEditStrategyIndicator_desc(int index) async {
    try {
      strategyIndicatorList[index] = IndicatorListModel(
        indicatorName: indicatorNameController_trade.text,
        indicatorDesc: indicatorDescController_trade.text,
      );
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // DESC PAGE /////////////////////////////////////////////////////////////////////////////////////////

// TRADE PAGE  /////////////////////////////////////////////////////////////////////////////////////////
  var toggleCapitalCurve_trade = false.obs;
  Future<void> getToggleCapitalCurve() async {
    try {
      toggleCapitalCurve_trade.value = !toggleCapitalCurve_trade.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  TextEditingController budgetController_trade = TextEditingController();
  var budgetTypeList_trade = ['\$', '%'].obs;
  var budgetTypeValue_trade = '%'.obs;

  TextEditingController tradePercentageController_trade =
      TextEditingController();
  var tradeTypeList_trade = ['\$', '%'].obs;
  var tradeTypeValue_trade = '%'.obs;

  var tradingList = <TradingListModel>[].obs;

  var timeframeWidget_trade = [
    const Text("1m"),
    const Text("3m"),
    const Text("5m"),
    const Text("15m"),
    const Text("30m"),
    const Text("45m"),
    const Text("1h"),
    const Text("2h"),
    const Text("3h"),
    const Text("4h"),
    const Text("1D"),
    const Text("1W"),
    const Text("1M"),
  ].obs;
  var timeframeValue_trade = "1m".obs;
  var timeframeIsSelected_trade = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ].obs;

  TextEditingController feeController_trade = TextEditingController();
  var feeTypeList_trade = ['\$', '%'].obs;
  var feeTypeValue_trade = '%'.obs;

  TextEditingController leverageController_trade = TextEditingController();
  var leverage_trade = 1.0.obs;
  var leverageTemp_trade = 1.0.obs;

  TextEditingController tradingPairController_trade = TextEditingController();
  var tradingPair_trade = "BTC/USDT".obs;

  var tradePercentage_trade = 0.0.obs;
  var tradeNominal_trade = 0.0.obs;
  var feePercentage_trade = 0.0.obs;
  var feeNominal_trade = 0.0.obs;
  var changes_trade = 0.0.obs;
  var cap_trade = 0.0.obs;
  var budget_trade = 0.0.obs;
  var budgetPercentage_trade = 0.0.obs;

  Future setTimeframe_trade(int index) async {
    try {
      for (int buttonIndex = 0;
          buttonIndex < timeframeIsSelected_trade.length;
          buttonIndex++) {
        if (buttonIndex == index) {
          timeframeIsSelected_trade[buttonIndex] =
              !timeframeIsSelected_trade[buttonIndex];
          timeframeValue_trade.value =
              timeframeWidget_trade[index].data.toString();
        } else {
          timeframeIsSelected_trade[buttonIndex] = false;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getTimeframe_trade() async {
    try {
      for (var i = 0; i < timeframeWidget_trade.length; i++) {
        if (timeframeWidget_trade[i] == timeframeValue_trade.value)
          timeframeIsSelected_trade[i] = true;
        else
          timeframeIsSelected_trade[i] = false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setTradingPair_trade() async {
    try {
      tradingPair_trade.value = tradingPairController_trade.text;
      tradingPairController_trade.clear();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getTradingPair_trade() async {
    try {
      tradingPairController_trade.text = tradingPair_trade.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setBudget_trade() async {
    try {
      switch (budgetTypeValue_trade.value) {
        case '\$':
          budget_trade.value =
              (double.tryParse(budgetController_trade.text) ?? 0.0) *
                  leverage_trade.value;
          budgetPercentage_trade.value =
              (double.tryParse(budgetController_trade.text) ?? 0.0) /
                  initCap_desc.value *
                  100;
          break;
        case '%':
          if (tradingList.isNotEmpty) {
            budget_trade.value =
                (((double.tryParse(budgetController_trade.text) ?? 0.0) / 100) *
                        tradingList.last.cap) *
                    leverage_trade.value;
          } else {
            budget_trade.value =
                (((double.tryParse(budgetController_trade.text) ?? 0.0) / 100) *
                        initCap_desc.value) *
                    leverage_trade.value;
          }
          budgetPercentage_trade.value =
              double.tryParse(budgetController_trade.text) ?? 0.0;
          break;
        default:
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setProfitLoss_trade() async {
    try {
      switch (tradeTypeValue_trade.value) {
        case '\$':
          tradeNominal_trade.value =
              (double.tryParse(tradePercentageController_trade.text) ?? 0.0);
          tradePercentage_trade.value =
              ((double.tryParse(tradePercentageController_trade.text) ?? 0.0) *
                      100) /
                  budget_trade.value;
          break;
        case '%':
          tradePercentage_trade.value =
              (double.tryParse(tradePercentageController_trade.text) ?? 0.0);
          tradeNominal_trade.value =
              ((double.tryParse(tradePercentageController_trade.text) ?? 0.0) /
                      100) *
                  (budget_trade.value);
          break;
        default:
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setFee_trade() async {
    try {
      switch (feeTypeValue_trade.value) {
        case '\$':
          feeNominal_trade.value =
              double.tryParse(feeController_trade.text) ?? 0.0;
          feePercentage_trade.value =
              ((double.tryParse(feeController_trade.text) ?? 0.0) * 100) /
                  budget_trade.value;
          break;
        case '%':
          feePercentage_trade.value =
              double.tryParse(feeController_trade.text) ?? 0.0;
          feeNominal_trade.value =
              ((double.tryParse(feeController_trade.text) ?? 0.0) / 100) *
                  budget_trade.value;
          break;
        default:
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setLeverage() async {
    try {
      leverage_trade.value = leverageTemp_trade.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getLeverage() async {
    try {
      leverageTemp_trade.value = leverage_trade.value;
      leverageController_trade.text = leverageTemp_trade.round().toString();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setChanges_trade() async {
    try {
      changes_trade.value = tradeNominal_trade.value - feeNominal_trade.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setCap_trade() async {
    try {
      if (tradingList.isNotEmpty) {
        cap_trade.value = tradingList.last.cap + changes_trade.value;
      } else {
        cap_trade.value = initCap_desc.value + changes_trade.value;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setTrading_trade() async {
    try {
      setFee_trade();
      setLeverage();
      setBudget_trade();
      setProfitLoss_trade();
      setChanges_trade();
      setCap_trade();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future addTrade() async {
    try {
      tradingList.add(
        TradingListModel(
          tradePercentage: tradePercentage_trade.value,
          tradeNominal: tradeNominal_trade.value,
          feePercentage: feePercentage_trade.value,
          feeNominal: feeNominal_trade.value,
          leverage: leverage_trade.value,
          changes: changes_trade.value,
          cap: cap_trade.value,
          budget: budget_trade.value,
          budgetPerccentage: budgetPercentage_trade.value,
        ),
      );
      tradePercentageController_trade.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteTrade() {
    try {
      tradingList.removeLast();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
// TRADE PAGE  /////////////////////////////////////////////////////////////////////////////////////////

  // PERFORMANCE PAGE ///////////////////////////////////////////////////////////////////////////////////////////////////////
  // Fee
  var totalFee = 0.0.obs;
  var averageFee = 0.0.obs;

  // Total profit loss
  var grossProfit = 0.0.obs;
  var grossLoss = 0.0.obs;
  var netoProfit = 0.0.obs;
  var profitFactor = 0.0.obs;

  // Capital
  var finalCap = 0.0.obs;
  var totalVolume = 0.0.obs;
  var gain = 0.0.obs;

  // Trade & winrate
  var winTrade = 0.obs;
  var loseTrade = 0.obs;
  var totalTrade = 0.obs;
  var winrate = 100.0.obs;
  var consecutiveWin = 0.obs; // N
  var consecutiveLoss = 0.obs; // N

  // Largest trade
  var largestWinNominal = 0.0.obs;
  var largestLossNominal = 0.0.obs;
  var largestWinPercentage = 0.0.obs;
  var largestLossPercentage = 0.0.obs;

  // Average Trade
  var averageWinNominal = 0.0.obs;
  var averageLossNominal = 0.0.obs;
  var averageWinPercentage = 0.0.obs;
  var averageLossPercentage = 0.0.obs;
  var averageRatio = 0.0.obs; //N

  // Trade Factor
  var high = 0.0.obs;
  var highIndex = 0.obs; //N
  var low = 0.0.obs;
  var lowIndex = 0.obs; //N
  var lowAfterHigh = 0.obs; //N
  var highAfterlow = 0.obs; //N
  var runUpSequance = <Possibility>[].obs; // N
  // var runUpSequancePercentage = [].obs; // N
  var maxRunUpPercentage = 0.0.obs; // N
  var drawDownSequance = <Possibility>[].obs; //N
  // var drawDownSequancePercentage = [].obs; //N
  var maxDrawdownPercentage = 0.0.obs; //N

  Future<void> getPerformance_perf() async {
    try {
      // Total profit loss
      await Future<double>.sync(
        () => tradingList.sumOfDouble((element) => element.feeNominal),
      ).then(
        (value) => totalFee.value = value,
      );
      await Future<double>.sync(
        () => tradingList.avgOfDouble((element) => element.feeNominal),
      ).then((value) => averageFee.value = value);

      // Total profit loss
      await Future<double>.sync(
        () => tradingList.sumOfDouble(
          (element) => element.tradeNominal > 0 ? element.tradeNominal : 0,
        ),
      ).then((value) => grossProfit.value = value);
      await Future<double>.sync(
        () => tradingList.sumOfDouble(
          (element) => element.tradeNominal < 0 ? element.tradeNominal : 0,
        ),
      ).then((value) => grossLoss.value = value);
      await Future.sync(
        () => grossProfit.value - grossLoss.value - totalFee.value,
      ).then((value) => netoProfit.value = value);
      await Future<double>.sync(
        () => grossLoss.value == 0 ? 1 : -(grossProfit.value / grossLoss.value),
      ).then((value) => profitFactor.value = value);

      // Capital
      await Future<double>.sync(
        () => tradingList.isNotEmpty ? tradingList.last.cap : 0.0,
      ).then((value) => finalCap.value = value);
      await Future<double>.sync(
        () => tradingList.sumOfDouble((element) => element.budget),
      ).then((value) => totalVolume.value = value);
      await Future<double>.sync(
        () =>
            ((finalCap.value - initCap_desc.value) / initCap_desc.value) * 100,
      ).then((value) => gain.value = value);

      // Trade & winrate
      await Future<int>.sync(
        () => tradingList.countWhere((element) => element.tradeNominal > 0),
      ).then((value) => winTrade.value = value);
      await Future<int>.sync(
        () => tradingList.countWhere((element) => element.tradeNominal < 0),
      ).then((value) => loseTrade.value = value);
      await Future<int>.sync(
        () => tradingList.length,
      ).then((value) => totalTrade.value = value);
      await Future<double>.sync(
        () => tradingList.isEmpty
            ? 100
            : (winTrade.value / totalTrade.value) * 100,
      ).then((value) => winrate.value = value);
      await Future.sync(() {
        var tempA = 0;
        var tempB = 0;
        for (var element in tradingList) {
          if (element.tradeNominal >= 0) {
            tempA++;
          } else if (element.tradeNominal < 0) {
            if (tempA > tempB) {
              tempB = tempA;
            }
            tempA = 0;
          }
        }
        if (tempA > tempB) {
          tempB = tempA;
        }
        tempA = 0;
        return tempB;
      }).then((value) => consecutiveWin.value = value);
      await Future.sync(() async {
        var tempA = 0;
        var tempB = 0;
        for (var element in tradingList) {
          if (element.tradeNominal < 0) {
            tempA++;
          } else if (element.tradeNominal >= 0) {
            if (tempA > tempB) {
              tempB = tempA;
            }
            tempA = 0;
          }
        }
        if (tempA > tempB) {
          tempB = tempA;
        }
        tempA = 0;
        return tempB;
      }).then((value) => consecutiveLoss.value = value);

      // Largest trade
      await Future<double>.sync(
        () => tradingList.maxOf(
            (element) => element.tradeNominal > 0 ? element.tradeNominal : 0),
      ).then((value) => largestWinNominal.value = value); // N
      await Future<double>.sync(
        () => tradingList.minOf(
            (element) => element.tradeNominal < 0 ? element.tradeNominal : 0),
      ).then((value) => largestLossNominal.value = value); // N
      await Future<double>.sync(
        () => tradingList.maxOf((element) =>
            element.tradePercentage > 0 ? element.tradePercentage : 0),
      ).then((value) => largestWinPercentage.value = value); // N
      await Future<double>.sync(
        () => tradingList.minOf((element) =>
            element.tradePercentage < 0 ? element.tradePercentage : 0),
      ).then((value) => largestLossPercentage.value = value); // N

      // Average Trade
      await Future<double>.sync(
        () => winTrade.value != 0
            ? tradingList.sumOfDouble((element) =>
                    element.tradeNominal > 0 ? element.tradeNominal : 0) /
                winTrade.value
            : 0.0,
      ).then((value) => averageWinNominal.value = value);
      await Future<double>.sync(
        () => loseTrade.value != 0
            ? tradingList.sumOfDouble((element) =>
                    element.tradeNominal < 0 ? element.tradeNominal : 0) /
                loseTrade.value
            : 0.0,
      ).then((value) => averageLossNominal.value = value);
      await Future<double>.sync(
        () => winTrade.value != 0
            ? tradingList.sumOfDouble((element) =>
                    element.tradePercentage > 0 ? element.tradePercentage : 0) /
                winTrade.value
            : 0.0,
      ).then((value) => averageWinPercentage.value = value);
      await Future<double>.sync(
        () => loseTrade.value != 0
            ? tradingList.sumOfDouble((element) =>
                    element.tradePercentage < 0 ? element.tradePercentage : 0) /
                loseTrade.value
            : 0.0,
      ).then((value) => averageLossPercentage.value = value);
      await Future<double>.sync(
        () => averageWinNominal.value / averageLossNominal.value,
      ).then((value) => averageRatio.value = value);

      // Trade Factor
      await Future<double>.sync(
        () => tradingList.maxOf((element) => element.cap),
      ).then((value) => high.value = value);
      await Future<int>.sync(
        () => tradingList.map((e) => e.cap).toList().indexOf(high.value),
      ).then((value) => highIndex.value = value);
      await Future<double>.sync(
        () => initCap_desc.value < low.value
            ? initCap_desc.value
            : tradingList.minOf((element) => element.cap),
      ).then((value) => low.value = value);
      await Future<int>.sync(
        () => tradingList.map((e) => e.cap).toList().indexOf(low.value),
      ).then((value) => lowIndex.value = value);

      lowAfterHigh.value = 0;
      highAfterlow.value = 0;

      Future.sync(() {
        runUpSequance.value = [];
        maxRunUpPercentage.value = 0.0;
        List tempList = [];
        double getLast = tradingList.last.cap;
        for (var i = 0; i < tradingList.length; i++) {
          if (i < 1) {
            tempList.add(tradingList[i].cap);
          } else {
            if (getLast != tradingList[i].cap) {
              if (tradingList[i].cap < tradingList[i - 1].cap &&
                  tradingList[i].cap < tradingList[i + 1].cap) {
                tempList.add(tradingList[i].cap);
              }
            }
            if (tradingList[i].cap > tradingList[i - 1].cap) {
              tempList.add(tradingList[i].cap);
            }
            if (getLast != tradingList[i].cap) {
              if (tradingList[i].cap > tradingList[i + 1].cap) {
                if (tempList.isNotEmpty) {
                  runUpSequance.add(
                    Possibility(
                      maxSequance: tempList,
                      maxSequancePercentage: 1,
                    ),
                  );
                }
                tempList = [];
              }
            }
          }
        }
        return runUpSequance.value;
      }).then((value) {
        Future.sync(() {
          for (var i = 0; i < value.length; i++) {
            value[i] = Possibility(
              maxSequance: value[i].maxSequance,
              maxSequancePercentage:
                  ((value[i].maxSequance.last - value[i].maxSequance.first) /
                          value[i].maxSequance.first) *
                      100,
            );
          }
          return runUpSequance.value;
        }).then((value) => maxRunUpPercentage.value =
            runUpSequance.maxOf((element) => element.maxSequancePercentage));
      });

      Future.sync(() {
        drawDownSequance.value = [];
        maxDrawdownPercentage.value = 0.0;
        List tempList = [];
        double getLast = tradingList.last.cap;
        for (var i = 0; i < tradingList.length; i++) {
          if (i < 1) {
            tempList.add(tradingList[i].cap);
          } else {
            if (getLast != tradingList[i].cap) {
              if (tradingList[i].cap > tradingList[i - 1].cap &&
                  tradingList[i].cap > tradingList[i + 1].cap) {
                tempList.add(tradingList[i].cap);
              }
            }
            if (tradingList[i].cap < tradingList[i - 1].cap) {
              tempList.add(tradingList[i].cap);
            }
            if (getLast != tradingList[i].cap) {
              if (tradingList[i].cap < tradingList[i + 1].cap) {
                if (tempList.isNotEmpty) {
                  drawDownSequance.add(
                    Possibility(
                      maxSequance: tempList,
                      maxSequancePercentage: 1,
                    ),
                  );
                }
                tempList = [];
              }
            }
          }
        }
        return drawDownSequance.value;
      }).then((value) {
        Future.sync(() {
          for (var i = 0; i < value.length; i++) {
            value[i] = Possibility(
              maxSequance: value[i].maxSequance,
              maxSequancePercentage:
                  ((value[i].maxSequance.last - value[i].maxSequance.first) /
                          value[i].maxSequance.first) *
                      100,
            );
          }
          return value;
        }).then((value) => maxDrawdownPercentage.value =
            drawDownSequance.minOf((element) => element.maxSequancePercentage));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // PERFORMANCE PAGE ///////////////////////////////////////////////////////////////////////////////////////////////////////

  // ADS ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  final BannerAd listBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  final BannerAd tradeBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  late InterstitialAd interstitialAd;
  var adIsLoaded = false.obs;

  Future loadInterstitialAd() async {
    try {
      InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
            adIsLoaded.value = true;
            debugPrint(
                "ADS LOADED ADS LOADED ADS LOADED ADS LOADED ADS LOADED");
            interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              adIsLoaded.value = false;
              interstitialAd.dispose();
              Get.back();
            }, onAdFailedToShowFullScreenContent: (ad, error) {
              adIsLoaded.value = false;
              interstitialAd.dispose();
              Get.back();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // ADS ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> saveStrategy() async {
    try {
      ever(strategyList, (_) {
        GetStorage().write('strategies', strategyList.toList());
        debugPrint("Strategy saved ${strategyList.length}");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getSavedStrategy() async {
    try {
      List? storedPw = GetStorage().read<List>('strategies');
      if (!storedPw.isNull) {
        strategyList.value =
            storedPw!.map((e) => StrategyListModel.fromJson(e)).toList();
      }

      debugPrint("Get saved strategy ${strategyList.length}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();

    // List? storedPw = GetStorage().read<List>('storedStrategy');
    // if (!storedPw.isNull) {
    //   strategyList.value =
    //       storedPw!.map((e) => StrategyListModel.fromJson(e)).toList();
    // }
    // ever(strategyList, (_) {
    //   GetStorage().write('storedStrategy', strategyList.toList());
    //   // GetStorage().write('storedStrategy', jsonEncode(strategyList.toString()));
    // });

    // List? storedPw = GetStorage().read<List>('strategies');
    // if (!storedPw.isNull) {
    //   strategyList.value =
    //       storedPw!.map((e) => StrategyListModel.fromJson(e)).toList();
    // }

    // ever(strategyList, (_) {
    //   GetStorage().write('strategies', strategyList.toList());
    //   debugPrint("Strategy saved ${strategyList.length}");
    // });
    saveStrategy();
    getSavedStrategy();

    // List? storedPw = GetStorage().read<List>('strategies');
    // if (!storedPw.isNull) {
    //   strategyList.value =
    //       storedPw!.map((e) => StrategyListModel.fromJson(e)).toList();
    // }

    // ever(strategyList, (_) {
    //   GetStorage().write('strategies', strategyList.toList());
    //   debugPrint("Strategy saved ${strategyList.length}");
    // });

    listBanner.load();
    tradeBanner.load();
  }
}
