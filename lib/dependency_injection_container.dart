
import 'package:get_it/get_it.dart';
import 'package:umesh_bingo/view_models/bingo_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => BingoViewModel());
}
