import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int selectedIndex = 0;
  CoinCard btc = CoinCard(coin: 'BTC');
  CoinCard eth = CoinCard(coin: 'ETH');
  CoinCard ltc = CoinCard(coin: 'LTC');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          btc,
          eth,
          ltc,
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isIOS
                ? buildCupertinoPicker()
                : buildDropdownButton()),
          ),
        ],
      ),
    );
  }

  CupertinoPicker buildCupertinoPicker() {
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
          });
        },
        children: getCupertinoChildren());
  }

  List<Widget> getCupertinoChildren() {
    List<Widget> res = List<Text>();
    for (String item in currenciesList) {
      res.add(Text(item));
    }
    return res;
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: buildDropdownMenuItem(),
      onChanged: (currency) {
        btc.changeRate(currency);
        eth.changeRate(currency);
        ltc.changeRate(currency);
//        print(value);
        setState(() {
          selectedCurrency = currency;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItem() {
    List<DropdownMenuItem<String>> res = new List<DropdownMenuItem<String>>();
    for (String item in currenciesList) {
      res.add(DropdownMenuItem(child: Text(item), value: item));
    }
    return res;
  }
}
