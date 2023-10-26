import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cargo/cargo.dart';
import '../entity/cargo/cargo_list_parameter.dart';

abstract class CargoRepository {
  FutureProcessing<LoadDataResult<List<Cargo>>> cargoList(CargoListParameter cargoListParameter);
}