import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_code_challenge/constants/texts.dart';
import 'package:flutter_code_challenge/models/beer/beer_model.dart';

class BeerList extends StatefulWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  Future<List<BeerModel>> getBeers() async {
    const url = 'https://api.punkapi.com/v2/beers';
    final response = await http.get(Uri.parse(url));

    List<dynamic> data = jsonDecode(response.body);
    List<BeerModel> beers =
        data.map((data) => BeerModel.fromJson(data)).toList();
    return beers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<List<BeerModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('😔 ${snapshot.error}');
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                BeerModel beer = snapshot.data![index];
                return Text(beer.name);
              },
            );
          } else {
            return const Text('NONE');
          }
        },
        future: getBeers(),
      ),
    );
  }
}
