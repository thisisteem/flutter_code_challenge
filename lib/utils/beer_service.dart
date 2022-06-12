import 'package:flutter_code_challenge/models/beer_model.dart';

class BeerService {
  final List<BeerModel> _beers = [];

  Future<List<BeerModel>> getBeers() async {
    return _beers;
  }
}
