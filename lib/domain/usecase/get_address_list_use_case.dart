import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/address.dart';
import '../entity/address/address_list_parameter.dart';
import '../repository/address_repository.dart';

class GetAddressListUseCase {
  final AddressRepository addressRepository;

  const GetAddressListUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<List<Address>>> execute(AddressListParameter addressListParameter) {
    return addressRepository.addressList(addressListParameter);
  }
}