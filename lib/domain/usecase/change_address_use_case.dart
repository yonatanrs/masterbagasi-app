import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/change_address_parameter.dart';
import '../entity/address/change_address_response.dart';
import '../repository/address_repository.dart';

class ChangeAddressUseCase {
  final AddressRepository addressRepository;

  const ChangeAddressUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<ChangeAddressResponse>> execute(ChangeAddressParameter changeAddressParameter) {
    return addressRepository.changeAddress(changeAddressParameter);
  }
}