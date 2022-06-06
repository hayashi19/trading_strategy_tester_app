class StrategyListModel {
  double initailCapital, leverage;
  int timeframe;
  String strategyName, tradingPair, indicatorDesc, durationTrade;
  List tradingBudget,
      winLosePercentage,
      winLoseNominal,
      feePaid,
      capitalChanges,
      flSpotList;

  StrategyListModel({
    required this.initailCapital,
    required this.leverage,
    required this.strategyName,
    required this.tradingPair,
    required this.timeframe,
    required this.indicatorDesc,
    required this.durationTrade,
    required this.tradingBudget,
    required this.winLosePercentage,
    required this.winLoseNominal,
    required this.feePaid,
    required this.capitalChanges,
    required this.flSpotList,
  });

  factory StrategyListModel.fromJson(Map<String, dynamic> json) =>
      StrategyListModel(
        initailCapital: json['initailCapital'],
        leverage: json['leverage'],
        strategyName: json['strategyName'],
        tradingPair: json['tradingPair'],
        timeframe: json['timeframe'],
        indicatorDesc: json['indicatorDesc'],
        durationTrade: json['durationTrade'],
        tradingBudget: json['tradingBudget'],
        winLosePercentage: json['winLosePercentage'],
        winLoseNominal: json['winLoseNominal'],
        feePaid: json['feePaid'],
        capitalChanges: json['capitalChanges'],
        flSpotList: json['flSpotList'],
      );

  Map<String, dynamic> toJson() => {
        'initailCapital': initailCapital,
        'leverage': leverage,
        'strategyName': strategyName,
        'tradingPair': tradingPair,
        'timeframe': timeframe,
        'indicatorDesc': indicatorDesc,
        'durationTrade': durationTrade,
        'tradingBudget': tradingBudget,
        'winLosePercentage': winLosePercentage,
        'winLoseNominal': winLoseNominal,
        'feePaid': feePaid,
        'capitalChanges': capitalChanges,
        'flSpotList': flSpotList,
      };
}
