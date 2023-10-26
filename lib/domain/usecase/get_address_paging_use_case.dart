import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/address.dart';
import '../entity/address/address_paging_parameter.dart';
import '../repository/address_repository.dart';

class GetAddressPagingUseCase {
  final AddressRepository addressRepository;

  const GetAddressPagingUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<Address>>> execute(AddressPagingParameter addressPagingParameter) {
    return addressRepository.addressPaging(addressPagingParameter);
  }
}