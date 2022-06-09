import 'package:flutter_code_challenge/models/beer/hops_model.dart';
import 'malt_model.dart';

class IngredientsModel {
  final List<MaltModel> malt;
  final List<HopsModel> hops;
  final String yeast;

  IngredientsModel({
    required this.malt,
    required this.hops,
    required this.yeast,
  });
}
