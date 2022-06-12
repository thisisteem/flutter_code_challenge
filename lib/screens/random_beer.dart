import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../constants/texts.dart';
import '../models/beer_model.dart';

class RandomBeer extends StatefulWidget {
  const RandomBeer({Key? key}) : super(key: key);

  @override
  _RandomBeerState createState() => _RandomBeerState();
}

class _RandomBeerState extends State<RandomBeer> {
  // late final Future<BeerModel> _getBeerFuture = getBeers();
  late BeerModel _beer;

  bool isLoading = false;

  Future<BeerModel> getBeers() async {
    setState(() {
      isLoading = true;
    });

    const url = 'https://api.punkapi.com/v2/beers/random';
    final response = await http.get(Uri.parse(url));

    List<dynamic> data = jsonDecode(response.body);
    _beer = data.map((data) => BeerModel.fromJson(data)).toList()[0];

    setState(() {
      isLoading = false;
    });

    return _beer;
  }

  @override
  void initState() {
    super.initState();

    getBeers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(randomTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildBeer(_beer),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeer(BeerModel beer) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl:
                    beer.imageUrl ?? "https://images.punkapi.com/v2/keg.png",
                height: 220,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 22,
        ),
        Text(
          beer.name,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 22,
        ),
        _buildInfo('ABV', '${beer.abv.toString()} %'),
        const Divider(),
        _buildInfo('IBU', beer.ibu.toString()),
        const Divider(),
        _buildInfo('EBC', beer.ebc.toString()),
        const Divider(),
        _buildInfo('First Brewed', beer.firstBrewed),
        const Divider(),
      ],
    );
  }

  Widget _buildButton() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  setState(() {
                    isLoading = true;
                  });
                  getBeers();
                },
          child: const Icon(
            Icons.sync,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          detail,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
