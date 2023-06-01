import 'dart:convert';

class StrategyListModel {
  String strategyTitle, startDate, endDate, timeframe, currency, tradingPair;
  double initCap;
  List<IndicatorListModel> indicator;
  List<TradingListModel> trade;
  // List indicatorName,
  //     indicatorDesc,
  //     tradePercentage,
  //     tradeNominal,
  //     feePercentage,
  //     feeNominal,
  //     leverage,
  //     changes,
  //     cap,
  //     budget,
  //     budgetPercentage;

  StrategyListModel({
    required this.strategyTitle,
    required this.startDate,
    required this.endDate,
    required this.initCap,
    required this.currency,
    required this.tradingPair,
    required this.timeframe,
    required this.indicator,
    required this.trade,
    // required this.indicatorName,
    // required this.indicatorDesc,
    // required this.tradePercentage,
    // required this.tradeNominal,
    // required this.feePercentage,
    // required this.feeNominal,
    // required this.leverage,
    // required this.changes,
    // required this.cap,
    // required this.budget,
    // required this.budgetPercentage,
  });

  factory StrategyListModel.fromJson(Map json) => StrategyListModel(
        strategyTitle: json['strategyTitle'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        initCap: json['initCap'],
        currency: json['currency'],
        timeframe: json['timeframe'],
        tradingPair: json['tradingPair'],

        indicator:
            // List<IndicatorListModel>.from(json.map(
            //   json['indicator'],
            // )) ,
            List<IndicatorListModel>.from(
                jsonDecode(json['indicator'].toString())
                    .map((data) => IndicatorListModel.fromJson(data))),
        // List<IndicatorListModel>.from(
        //   jsonDecode(
        //     json['indicator'].toString(),
        //   ),
        // ),
        trade: List<TradingListModel>.from(jsonDecode(json['trade'].toString())
            .map((data) => TradingListModel.fromJson(data))),
        // List<TradingListModel>.from(
        //     List<Map<String, dynamic>>.from(jsonDecode(
        //   json['indicator'].toString(),
        // ))),
        // List<TradingListModel>.from(
        //   jsonDecode(
        //     json['trade'].toString(),
        //   ),
        // ).toList(),
        // budgetPercentage: json['budgetPercentage'],
        // indicatorName: json['indicatorName'],
        // indicatorDesc: json['indicatorDesc'],
        // tradePercentage: json['tradePercentage'],
        // tradeNominal: json['tradeNominal'],
        // feePercentage: json['feePercentage'],
        // feeNominal: json['feeNominal'],
        // leverage: json['leverage'],
        // changes: json['changes'],
        // cap: json['cap'],
        // budget: json['budget'],
      );

  Map toJson() => {
        'strategyTitle': strategyTitle,
        'startDate': startDate,
        'endDate': endDate,
        'initCap': initCap,
        'currency': currency,
        'timeframe': timeframe,
        'tradingPair': tradingPair,
        'indicator': jsonEncode(indicator.toList()),
        'trade': jsonEncode(trade.toList()),
        // 'budgetPercentage': budgetPercentage,
        // 'indicatorName': indicatorName,
        // 'indicatorDesc': indicatorDesc,
        // 'tradePercentage': tradePercentage,
        // 'tradeNominal': tradeNominal,
        // 'feePercentage': feePercentage,
        // 'feeNominal': feeNominal,
        // 'leverage': leverage,
        // 'changes': changes,
        // 'cap': cap,
        // 'budget': budget,
      };
}

class IndicatorListModel {
  String indicatorName, indicatorDesc;

  IndicatorListModel({
    required this.indicatorName,
    required this.indicatorDesc,
  });

  factory IndicatorListModel.fromJson(Map<String, dynamic> json) =>
      IndicatorListModel(
        indicatorName: json['indicatorName'],
        indicatorDesc: json['indicatorDesc'],
      );

  Map<String, dynamic> toJson() => {
        'indicatorName': indicatorName,
        'indicatorDesc': indicatorDesc,
      };
}

class TradingListModel {
  double tradePercentage,
      tradeNominal,
      feePercentage,
      feeNominal,
      leverage,
      changes,
      cap,
      budget,
      budgetPerccentage;

  TradingListModel({
    required this.tradePercentage,
    required this.tradeNominal,
    required this.feePercentage,
    required this.feeNominal,
    required this.leverage,
    required this.changes,
    required this.cap,
    required this.budget,
    required this.budgetPerccentage,
  });

  factory TradingListModel.fromJson(Map json) => TradingListModel(
        tradePercentage: json['tradePercentage'],
        tradeNominal: json['tradeNominal'],
        feePercentage: json['feePercentage'],
        feeNominal: json['feeNominal'],
        leverage: json['leverage'],
        changes: json['changes'],
        cap: json['cap'],
        budget: json['budget'],
        budgetPerccentage: json['budgetPerccentage'],
      );

  Map<String, dynamic> toJson() => {
        'tradePercentage': tradePercentage,
        'tradeNominal': tradeNominal,
        'feePercentage': feePercentage,
        'feeNominal': feeNominal,
        'leverage': leverage,
        'changes': changes,
        'cap': cap,
        'budget': budget,
        'budgetPerccentage': budgetPerccentage,
      };
}

class Possibility {
  List maxSequance;
  double maxSequancePercentage;

  Possibility({
    required this.maxSequance,
    required this.maxSequancePercentage,
  });

  factory Possibility.fromJson(Map json) => Possibility(
        maxSequance: json['maxSequance'],
        maxSequancePercentage: json['maxSequancePercentage'],
      );

  Map<String, dynamic> toJson() => {
        'maxSequance': maxSequance,
        'maxSequancePercentage': maxSequancePercentage,
      };
}
