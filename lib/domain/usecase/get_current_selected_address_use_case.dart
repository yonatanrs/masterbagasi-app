import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/current_selected_address_parameter.dart';
import '../entity/address/current_selected_address_response.dart';
import '../repository/address_repository.dart';

class GetCurrentSelectedAddressUseCase {
  final AddressRepository addressRepository;

  const GetCurrentSelectedAddressUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<CurrentSelectedAddressResponse>> execute(CurrentSelectedAddressParameter currentSelectedAddressParameter) {
    return addressRepository.currentSelectedAddress(currentSelectedAddressParameter);
  }
}