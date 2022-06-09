import 'package:flutter/material.dart';

class BeerDetail extends StatefulWidget {
  const BeerDetail({Key? key}) : super(key: key);

  @override
  _BeerDetailState createState() => _BeerDetailState();
}

class _BeerDetailState extends State<BeerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Beer Detail'),
      ),
      body: Center(
        child: Text(
          'Beer Detail',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
