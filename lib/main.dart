import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kripto_uygulamasi/coinModel.dart';
import 'package:kripto_uygulamasi/favoriler.dart';
import 'package:kripto_uygulamasi/giris_Yap.dart';
import 'package:kripto_uygulamasi/navigation_drawer.dart';

import 'coinCard.dart';
import 'hakkinda.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GirisEkrani());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }

        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Coinler yüklenemedi!');
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 5), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerScrimColor: Colors.pink,
        backgroundColor: Colors.grey[120],
        appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text('Coin Uygulaması'),
            actions: [

              InkWell(
                child: Icon(Icons.favorite
                ),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> favoriler()));
                } ,
              )
              ,
            ]
        ),
        drawer: NavigationDrawerWidget(),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: coinList.length,
          itemBuilder: (context, index) {
            return CoinCard(
              name: coinList[index].name,
              symbol: coinList[index].symbol.toUpperCase(),
              imageUrl: coinList[index].imageUrl,
              price: coinList[index].price.toDouble(),
              change: coinList[index].change.toDouble(),
              changePercentage: coinList[index].changePercentage.toDouble(),
            );
          },
        ));
  }
}
