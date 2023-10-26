import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/update_current_selected_address_parameter.dart';
import '../entity/address/update_current_selected_address_response.dart';
import '../repository/address_repository.dart';

class UpdateCurrentSelectedAddressUseCase {
  final AddressRepository addressRepository;

  const UpdateCurrentSelectedAddressUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<UpdateCurrentSelectedAddressResponse>> execute(UpdateCurrentSelectedAddressParameter updateCurrentSelectedAddressParameter) {
    return addressRepository.updateCurrentSelectedAddress(updateCurrentSelectedAddressParameter);
  }
}