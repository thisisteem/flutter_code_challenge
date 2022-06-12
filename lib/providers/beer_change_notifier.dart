import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/models/beer_model.dart';

import '../utils/beer_service.dart';

class BeerChangeNotifier extends ChangeNotifier {
  final BeerService _beerService;

  BeerChangeNotifier(this._beerService);

  List<BeerModel> _beers = [];

  List<BeerModel> get beers => _beers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getBeers() async {
    // TODO: Implement
  }
}
