
// // insert ltd data
// Future insertLtdData(LtdDataModel ltdDataModel) async {
// late Map<String, dynamic> tempdata;
// Database? db = await instance.database;
// var batch = db?.batch();
// for (var val in ltdDataModel.ltd) {
// bool isDataAvailable = await getLTPDataFromDateSymbol(
// DateFormat('yyyy-MM-dd').format(val.businessDate).toString(),
// val.symbol);
// if (isDataAvailable == false) {
// tempdata = {
// "businessDate":
// DateFormat('yyyy-MM-dd').format(val.businessDate).toString(),
// "symbol": val.symbol,
// "securityName": val.securityName,
// "securityId": val.securityId,
// "openPrice": val.openPrice,
// "highPrice": val.highPrice,
// "lowPrice": val.lowPrice,
// "closePrice": val.closePrice,
// "totalTradedQuantity": val.totalTradedQuantity,
// "totalTradedValue": val.totalTradedValue,
// "previousDayClosePrice": val.previousDayClosePrice,
// "fiftyTwoWeekHigh": val.fiftyTwoWeekHigh,
// "fiftyTwoWeekLow": val.fiftyTwoWeekLow,
// "lastUpdatedDate":
// DateFormat('yyyy-MM-dd').format(val.lastUpdatedTime).toString(),
// "lastUpdatedTime":
// DateFormat('HH:mm').format(val.lastUpdatedTime).toString(),
// "lastUpdatedPrice": val.lastUpdatedPrice,
// "totalTrades": val.totalTrades,
// "averageTradedPrice": val.averageTradedPrice,
// "marketCapitalization": val.marketCapitalization,
// };
// batch!.insert(ltdTable, tempdata,
// conflictAlgorithm: ConflictAlgorithm.replace);
// } else {
// tempdata = {
// "businessDate":
// DateFormat('yyyy-MM-dd').format(val.businessDate).toString(),
// "symbol": val.symbol,
// "securityName": val.securityName,
// "securityId": val.securityId,
// "openPrice": val.openPrice,
// "highPrice": val.highPrice,
// "lowPrice": val.lowPrice,
// "closePrice": val.closePrice,
// "totalTradedQuantity": val.totalTradedQuantity,
// "totalTradedValue": val.totalTradedValue,
// "previousDayClosePrice": val.previousDayClosePrice,
// "fiftyTwoWeekHigh": val.fiftyTwoWeekHigh,
// "fiftyTwoWeekLow": val.fiftyTwoWeekLow,
// "lastUpdatedDate":
// DateFormat('yyyy-MM-dd').format(val.lastUpdatedTime).toString(),
// "lastUpdatedTime":
// DateFormat('HH:mm').format(val.lastUpdatedTime).toString(),
// "lastUpdatedPrice": val.lastUpdatedPrice,
// "totalTrades": val.totalTrades,
// "averageTradedPrice": val.averageTradedPrice,
// "marketCapitalization": val.marketCapitalization,
// };
// batch!.update(ltdTable, tempdata,
// where: 'businessDate=? and symbol=?',
// whereArgs: [
// '${DateFormat('yyyy-MM-dd').format(val.businessDate).toString()}',
// '${val.symbol}'
// ]);
// }
// }
// await batch!.commit();
// return null;
// }

