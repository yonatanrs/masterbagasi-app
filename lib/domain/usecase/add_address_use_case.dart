import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/add_address_parameter.dart';
import '../entity/address/add_address_response.dart';
import '../repository/address_repository.dart';

class AddAddressUseCase {
  final AddressRepository addressRepository;

  const AddAddressUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<AddAddressResponse>> execute(AddAddressParameter addAddressParameter) {
    return addressRepository.addAddress(addAddressParameter);
  }
}