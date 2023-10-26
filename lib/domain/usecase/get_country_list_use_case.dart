import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/address/country.dart';
import '../entity/address/country_list_parameter.dart';
import '../repository/address_repository.dart';

class GetCountryListUseCase {
  final AddressRepository addressRepository;

  const GetCountryListUseCase({
    required this.addressRepository
  });

  FutureProcessing<LoadDataResult<List<Country>>> execute(CountryListParameter countryListParameter) {
    return addressRepository.countryList(countryListParameter);
  }
}