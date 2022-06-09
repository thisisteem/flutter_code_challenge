import 'fermentation_model.dart';
import 'mash_temp.dart';

class MethodModel {
  final List<MashTempModel> mashTemp;
  final FermentationModel fermentation;
  final String? twist;

  MethodModel({
    required this.mashTemp,
    required this.fermentation,
    this.twist,
  });
}
