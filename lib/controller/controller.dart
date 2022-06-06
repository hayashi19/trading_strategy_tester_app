// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toast/toast.dart';
import 'package:trading_strategy_tester_app/controller/list_model.dart';

class AllPageController extends GetxController with WidgetsBindingObserver {
  var strategyList = RxList<StrategyListModel>();

  TextEditingController strategyNameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController initialCapitalController = TextEditingController();
  TextEditingController tradingPairController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController percentageChangeController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController indicatorDescController = TextEditingController();

  createList() {
    strategyList.add(StrategyListModel(
      initailCapital: 100,
      leverage: 1,
      strategyName: "",
      tradingPair: "",
      timeframe: 0,
      indicatorDesc: "",
      durationTrade: "",
      tradingBudget: [],
      winLosePercentage: [],
      winLoseNominal: [],
      feePaid: [],
      capitalChanges: [],
      flSpotList: [],
    ));
  }

  var timeframeValue = 0.obs;
  var timeframeList = RxList<String>([
    "1s",
    "30s",
    "1m",
    "5m",
    "15m",
    "30m",
    "1h",
    "4h",
    "12h",
    "1D",
    "5D",
    "1W",
    "1M",
  ]);

  var tradingBudgetValue = [].obs;
  var winLosePercentageValue = [].obs;
  var winLoseNominalValue = [].obs;
  var feePaidValue = [].obs;
  var capitalChangesValue = [].obs;

  var flList = [].obs;
  var leverageValue = 1.obs;

  addTrade() {
    if (percentageChangeController.text.contains(",") ||
        feeController.text.contains(",")) {
      Toast.show("Value must be a number",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    } else if (budgetController.text.isEmpty) {
      Toast.show("Budget empty",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    } else {
      tradingBudgetValue.isEmpty
          ? tradingBudgetValue.add(
              (double.parse(initialCapitalController.text) *
                      leverageValue.value) *
                  (double.parse(budgetController.text) / 100))
          : tradingBudgetValue.add(
              (capitalChangesValue[capitalChangesValue.length - 1] *
                      leverageValue.value) *
                  (double.parse(budgetController.text) / 100));

      percentageChangeController.text.isEmpty
          ? winLosePercentageValue.add(0)
          : winLosePercentageValue
              .add(double.parse(percentageChangeController.text));

      winLoseNominalValue.add(
          tradingBudgetValue[tradingBudgetValue.length - 1] *
              (winLosePercentageValue[winLosePercentageValue.length - 1] /
                  100));

      feeController.text.isEmpty
          ? feePaidValue.add(0)
          : feePaidValue.add(
              (tradingBudgetValue[tradingBudgetValue.length - 1] *
                      leverageValue.value) *
                  (double.parse(feeController.text) / 100));

      capitalChangesValue.isEmpty
          ? capitalChangesValue.add(
              double.parse(initialCapitalController.text) +
                  winLoseNominalValue[winLoseNominalValue.length - 1] -
                  feePaidValue[feePaidValue.length - 1])
          : capitalChangesValue.add(
              capitalChangesValue[capitalChangesValue.length - 1] +
                  winLoseNominalValue[winLoseNominalValue.length - 1] -
                  feePaidValue[feePaidValue.length - 1]);

      flList.add(capitalChangesValue[capitalChangesValue.length - 1]);
    }
  }

  removeTradePrevious() {
    if (tradingBudgetValue.isEmpty) {
      Toast.show("List is empty",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    } else {
      tradingBudgetValue.removeLast();
      winLosePercentageValue.removeLast();
      winLoseNominalValue.removeLast();
      feePaidValue.removeLast();
      capitalChangesValue.removeLast();
      flList.removeLast();
    }
  }

  savedStrategy(int index) async {
    strategyList.insert(
        index,
        StrategyListModel(
          initailCapital: double.parse(initialCapitalController.text),
          leverage: leverageValue.value.toDouble(),
          strategyName: strategyNameController.text,
          tradingPair: tradingPairController.text,
          timeframe: timeframeValue.value,
          indicatorDesc: indicatorDescController.text,
          durationTrade: durationController.text,
          tradingBudget: tradingBudgetValue,
          winLosePercentage: winLosePercentageValue,
          winLoseNominal: winLoseNominalValue,
          feePaid: feePaidValue,
          capitalChanges: capitalChangesValue,
          flSpotList: flList,
        ));
    strategyList.removeAt(index + 1);

    strategyNameController.clear();
    durationController.clear();
    initialCapitalController.clear();
    tradingPairController.clear();
    budgetController.clear();
    percentageChangeController.clear();
    feeController.clear();
    indicatorDescController.clear();
    timeframeValue.value = 0;
    leverageValue.value = 1;

    Get.back();
  }

  onStartPage(int index) {
    initialCapitalController.text =
        strategyList[index].initailCapital.toString();
    leverageValue.value = strategyList[index].leverage.toInt();
    strategyNameController.text = strategyList[index].strategyName;
    tradingPairController.text = strategyList[index].tradingPair;
    timeframeValue.value = strategyList[index].timeframe;
    indicatorDescController.text = strategyList[index].indicatorDesc;
    durationController.text = strategyList[index].durationTrade;
    tradingBudgetValue = RxList(strategyList[index].tradingBudget);
    winLosePercentageValue = RxList(strategyList[index].winLosePercentage);
    winLoseNominalValue = RxList(strategyList[index].winLoseNominal);
    feePaidValue = RxList(strategyList[index].feePaid);
    capitalChangesValue = RxList(strategyList[index].capitalChanges);
    flList = RxList(strategyList[index].flSpotList);
    budgetController.text = "10";
  }

  foldLeft(List collection, double val, func) {
    for (var entry in collection) {
      val = func(val, entry);
    }
    return val;
  }

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

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
          adIsLoaded.value = true;
          print("ADS LOADED ADS LOADED ADS LOADED ADS LOADED ADS LOADED");

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
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    List? storedStrategy = GetStorage().read<List>('storedStrategy');
    if (!storedStrategy.isNull) {
      strategyList = RxList(
          storedStrategy!.map((e) => StrategyListModel.fromJson(e)).toList());
    }
    ever(strategyList, (_) {
      GetStorage().write('storedStrategy', strategyList.toList());
    });

    listBanner.load();
    tradeBanner.load();

    // ignore: todo
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // TODO: implement dispose
    super.dispose();
  }
}
