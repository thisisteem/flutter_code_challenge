import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/constants/texts.dart';

class BeerList extends StatefulWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: Center(
        child: Text(
          'Beer List',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
