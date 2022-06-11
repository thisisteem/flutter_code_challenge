import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/components/bullet_list_for_malt.dart';
import 'package:flutter_code_challenge/models/beer_model.dart';

import '../components/bullet_list.dart';
import '../components/bullet_list_for_hops.dart';
import '../constants/colors.dart';
import '../functions/ebc_to_color_code.dart';

class BeerDetail extends StatefulWidget {
  final BeerModel beer;
  const BeerDetail({Key? key, required this.beer}) : super(key: key);

  @override
  _BeerDetailState createState() => _BeerDetailState();
}

class _BeerDetailState extends State<BeerDetail> {
  late BeerModel beer = widget.beer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            beer.name,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildHeaderInfo(),
          _buildTagLine(),
          _buildDescription(),
          _buildFoorPairing(),
          _buildIngredients(),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorPrimaryDefault,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderValue('Alcohol', beer.abv, '%'),
                    const SizedBox(height: 16),
                    _buildHeaderValue('Bitterness', beer.ibu, 'IBU'),
                    const SizedBox(height: 16),
                    _buildHeaderValue('pH', beer.ph, ''),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    _buildColorTag(beer.ebc),
                    _buildImage(beer.imageUrl)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '"${beer.tagline}"',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black54, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Description',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  beer.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoorPairing() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Food Pairing',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          BulletList(
            strings: beer.foodPairing,
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Malt',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          BulletListForMalt(
            maltList: beer.ingredients.malt,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Hops',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          BulletListForHops(
            hopsList: beer.ingredients.hops,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Yeast',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BulletList(
            strings: [beer.ingredients.yeast],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderValue(dynamic header, dynamic body, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white),
        ),
        Text(
          body != null ? '${body.toString()} $unit' : 'N/A',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildColorTag(num? ebc) {
    bool isNull = ebc == null ? true : false;
    return Visibility(
      visible: !isNull,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 11),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: ebcToColorCode(ebc),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            child: Text(
              'Color',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(
      height: 150,
      imageUrl: imageUrl,
    );
  }
}
