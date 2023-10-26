import '../../../domain/entity/cargo/cargo.dart';
import '../../../domain/entity/cargo/cargo_list_parameter.dart';
import '../../../misc/processing/future_processing.dart';

abstract class CargoDataSource {
  FutureProcessing<List<Cargo>> cargoList(CargoListParameter cargoListParameter);
}