import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/remove_address_parameter.dart';
import '../entity/address/remove_address_response.dart';
import '../repository/address_repository.dart';

class RemoveAddressUseCase {
  final AddressRepository addressRepository;

  const RemoveAddressUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<RemoveAddressResponse>> execute(RemoveAddressParameter removeAddressParameter) {
    return addressRepository.removeAddress(removeAddressParameter);
  }
}