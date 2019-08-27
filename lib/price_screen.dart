import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_card.dart';
import 'dart:async';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  static StreamController<String> streamController =
      StreamController<String>.broadcast();
  int selectedIndex = 0;
  CoinCard btc =
      CoinCard(coin: 'BTC', sc: streamController.stream.asBroadcastStream());
  CoinCard eth =
      CoinCard(coin: 'ETH', sc: streamController.stream.asBroadcastStream());
  CoinCard ltc =
      CoinCard(coin: 'LTC', sc: streamController.stream.asBroadcastStream());
  CoinCard nxt =
      CoinCard(coin: 'XRP', sc: streamController.stream.asBroadcastStream());
  static String current = 'USD';
  static String last = 'USD';

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
          nxt,
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isIOS
                ? buildDropdownButton() /* buildCupertinoPicker() */
                : buildDropdownButton()),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: current,
      items: buildDropdownMenuItem(),
      onChanged: (currency) {
        if (current != currency) {
          last = current;
          setState(() {
            current = currency;
          });
          streamController.stream.asBroadcastStream();
          streamController.sink.add(current);
        }
//        print(value);
//        setState(() {
//          selectedCurrency = currency;
//        });
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

  CupertinoPicker buildCupertinoPicker() {
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
//          setState(() {
          current = currenciesList[selectedIndex];
//          });
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
}
