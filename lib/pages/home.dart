import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trading_strategy_tester_app/controller/controller.dart';
import 'package:trading_strategy_tester_app/pages/list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.put(AllPageController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Strategy List",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: StrategyListPage(),
            ),
          ),
          ADS(ad: allPageController.listBanner)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          allPageController.createList();
        },
        child: const Icon(Icons.add_chart_rounded),
      ),
    );
  }
}

// ignore: must_be_immutable
class ADS extends StatelessWidget {
  AdWithView ad;
  ADS({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
