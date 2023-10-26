import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/country.dart';
import '../entity/address/country_paging_parameter.dart';
import '../repository/address_repository.dart';

class GetCountryPagingUseCase {
  final AddressRepository addressRepository;

  const GetCountryPagingUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<Country>>> execute(CountryPagingParameter countryPagingParameter) {
    return addressRepository.countryPaging(countryPagingParameter);
  }
}