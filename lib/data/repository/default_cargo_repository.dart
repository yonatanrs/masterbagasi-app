import '../../domain/entity/cargo/cargo.dart';
import '../../domain/entity/cargo/cargo_list_parameter.dart';
import '../../domain/repository/cargo_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/cargodatasource/cargo_data_source.dart';

class DefaultCargoRepository implements CargoRepository {
  final CargoDataSource cargoDataSource;

  const DefaultCargoRepository({
    required this.cargoDataSource
  });

  @override
  FutureProcessing<LoadDataResult<List<Cargo>>> cargoList(CargoListParameter cargoListParameter) {
    return cargoDataSource.cargoList(cargoListParameter).mapToLoadDataResult<List<Cargo>>();
  }
}