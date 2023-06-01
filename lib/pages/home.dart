import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:trading_strategy_tester_app/pages/list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isMobile ? const StrategyList() : Container();
  }
}
