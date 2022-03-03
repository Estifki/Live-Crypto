import 'package:bitcoin_miner/Services/coin_data.dart';
import 'package:bitcoin_miner/Services/cryptoapi.dart';
import 'package:bitcoin_miner/constants.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double _currentConversionRateBTC = 0.0;
  double _currentConversionRateETH = 0.0;
  double _currentConversionRateLTC = 0.0;
  dynamic _currencyNameBTC, _currencyNameETH, _currencyNameLTC;
  var selectedCurrency = currenciesList[19];
  List<DropdownMenuItem> getCurrencyList() {
    List<DropdownMenuItem> currnencyList = [];
    for (String currency in currenciesList) {
      var items = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      currnencyList.add(items);
    }
    return currnencyList;
  }

  @override
  void initState() {
    getCurrencyRateData();
    super.initState();
  }

  Future getCurrencyRateData() async {
    NetworkHelper _networkHelperForBTC = NetworkHelper();
    await _networkHelperForBTC.fetchFromCryptoApi(
        "$khostaddress/BTC/$selectedCurrency?apiKey=$kApiKey");
    NetworkHelper _networkHelperForETH = NetworkHelper();
    await _networkHelperForETH.fetchFromCryptoApi(
        "$khostaddress/ETH/$selectedCurrency?apiKey=$kApiKey");
    NetworkHelper _networkHelperForLTC = NetworkHelper();
    await _networkHelperForLTC.fetchFromCryptoApi(
        "$khostaddress/LTC/$selectedCurrency?apiKey=$kApiKey");
    setState(() {
      _currentConversionRateBTC = _networkHelperForBTC.currentconversionRate;
      _currencyNameBTC = _networkHelperForBTC.currencyName;
      _currentConversionRateETH = _networkHelperForETH.currentconversionRate;
      _currencyNameETH = _networkHelperForETH.currencyName;
      _currentConversionRateLTC = _networkHelperForLTC.currentconversionRate;
      _currencyNameLTC = _networkHelperForLTC.currencyName;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrencyList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${_currentConversionRateBTC.toStringAsFixed(2)} ${_currencyNameBTC ?? "..."} ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${_currentConversionRateETH.toStringAsFixed(3)} ${_currencyNameETH ?? "..."}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${_currentConversionRateLTC.toStringAsFixed(3)} ${_currencyNameLTC ?? "..."}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 80.0,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<dynamic>(
              value: selectedCurrency,
              items: getCurrencyList(),
              onChanged: (val) {
                setState(() {
                  selectedCurrency = val;
                  getCurrencyRateData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
