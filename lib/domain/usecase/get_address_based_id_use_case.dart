import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/address.dart';
import '../entity/address/address_based_id_parameter.dart';
import '../repository/address_repository.dart';

class GetAddressBasedIdUseCase {
  final AddressRepository addressRepository;

  const GetAddressBasedIdUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<Address>> execute(AddressBasedIdParameter addressBasedIdParameter) {
    return addressRepository.addressBasedId(addressBasedIdParameter);
  }
}