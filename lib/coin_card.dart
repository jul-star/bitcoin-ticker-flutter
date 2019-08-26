import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CoinCard extends StatefulWidget {
  CoinCard({@required this.coin});
  final coin;
  void changeRate(String currency) {
    _CoinCardState(coin, currency, '1 $coin ? $currency');
    print('CoinCard: rate: $currency');
  }

  @override
  _CoinCardState createState() => _CoinCardState(coin, 'USD', '');
}

class _CoinCardState extends State<CoinCard> {
  _CoinCardState(this.coin, this.currency, this.rate) {
    getRate(coin, currency);
  }
  String coin;
  String currency;
  String rate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            rate,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getRate(String coin, String currency) async {
    String url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';
    String api = url + coin + currency;
    var response = await http.get(api);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      double rt = jsonResponse['bid'];
      rt ?? 0;
      setState(() {
        rate = '1 $coin = ' + rt.toString() + currency;
      });
    } else {
      print('Error');
    }
    return rate;
  }
}
