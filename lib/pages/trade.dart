// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:trading_strategy_tester_app/controller/ads.dart';
import 'package:trading_strategy_tester_app/controller/controller.dart';
import 'package:trading_strategy_tester_app/pages/trade/desc.dart';
import 'package:trading_strategy_tester_app/pages/trade/performance.dart';
import 'package:trading_strategy_tester_app/pages/trade/trading.dart';

class TradingPage extends StatelessWidget {
  int index;
  TradingPage({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final AllPageController controller = Get.put(AllPageController());
    return Scaffold(
      body: FutureBuilder(
        future: controller.getStrategy_trade(index),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
              length: 3,
              initialIndex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        const TabBarView(
                          children: [
                            PerformancePage(),
                            TradePage(),
                            DescPage(),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.saveTradingStrategy_trade(index);
                                  controller.interstitialAd.show();
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF495057),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(Icons.save_rounded),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ADS(ad: controller.tradeBanner),
                  const TabBar(
                    physics: BouncingScrollPhysics(),
                    labelColor: Color(0xFFADB5BD),
                    unselectedLabelColor: Color(0xFF495057),
                    indicatorColor: Color(0xFF495057),
                    tabs: [
                      Tab(icon: Icon(Icons.insert_chart_rounded)),
                      Tab(icon: Icon(Icons.candlestick_chart_rounded)),
                      Tab(icon: Icon(Icons.account_balance_wallet_rounded)),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
