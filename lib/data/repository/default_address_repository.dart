import '../../domain/entity/address/add_address_parameter.dart';
import '../../domain/entity/address/add_address_response.dart';
import '../../domain/entity/address/address.dart';
import '../../domain/entity/address/address_based_id_parameter.dart';
import '../../domain/entity/address/address_list_parameter.dart';
import '../../domain/entity/address/address_paging_parameter.dart';
import '../../domain/entity/address/change_address_parameter.dart';
import '../../domain/entity/address/change_address_response.dart';
import '../../domain/entity/address/country.dart';
import '../../domain/entity/address/country_list_parameter.dart';
import '../../domain/entity/address/country_paging_parameter.dart';
import '../../domain/entity/address/current_selected_address_parameter.dart';
import '../../domain/entity/address/current_selected_address_response.dart';
import '../../domain/entity/address/remove_address_parameter.dart';
import '../../domain/entity/address/remove_address_response.dart';
import '../../domain/entity/address/update_current_selected_address_parameter.dart';
import '../../domain/entity/address/update_current_selected_address_response.dart';
import '../../domain/repository/address_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/addressdatasource/address_data_source.dart';

class DefaultAddressRepository implements AddressRepository {
  final AddressDataSource addressDataSource;

  const DefaultAddressRepository({
    required this.addressDataSource
  });

  @override
  FutureProcessing<LoadDataResult<CurrentSelectedAddressResponse>> currentSelectedAddress(CurrentSelectedAddressParameter currentSelectedAddressParameter) {
    return addressDataSource.currentSelectedAddress(currentSelectedAddressParameter).mapToLoadDataResult<CurrentSelectedAddressResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<Address>>> addressPaging(AddressPagingParameter addressPagingParameter) {
    return addressDataSource.addressPaging(addressPagingParameter).mapToLoadDataResult<PagingDataResult<Address>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<Address>>> addressList(AddressListParameter addressListParameter) {
    return addressDataSource.addressList(addressListParameter).mapToLoadDataResult<List<Address>>();
  }

  @override
  FutureProcessing<LoadDataResult<UpdateCurrentSelectedAddressResponse>> updateCurrentSelectedAddress(UpdateCurrentSelectedAddressParameter updateCurrentSelectedAddressParameter) {
    return addressDataSource.updateCurrentSelectedAddress(updateCurrentSelectedAddressParameter).mapToLoadDataResult<UpdateCurrentSelectedAddressResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<List<Country>>> countryList(CountryListParameter countryListParameter) {
    return addressDataSource.countryList(countryListParameter).mapToLoadDataResult<List<Country>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<Country>>> countryPaging(CountryPagingParameter countryPagingParameter) {
    return addressDataSource.countryPaging(countryPagingParameter).mapToLoadDataResult<PagingDataResult<Country>>();
  }

  @override
  FutureProcessing<LoadDataResult<AddAddressResponse>> addAddress(AddAddressParameter addAddressParameter) {
    return addressDataSource.addAddress(addAddressParameter).mapToLoadDataResult<AddAddressResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<ChangeAddressResponse>> changeAddress(ChangeAddressParameter changeAddressParameter) {
    return addressDataSource.changeAddress(changeAddressParameter).mapToLoadDataResult<ChangeAddressResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<RemoveAddressResponse>> removeAddress(RemoveAddressParameter removeAddressParameter) {
    return addressDataSource.removeAddress(removeAddressParameter).mapToLoadDataResult<RemoveAddressResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<Address>> addressBasedId(AddressBasedIdParameter addressBasedIdParameter) {
    return addressDataSource.addressBasedId(addressBasedIdParameter).mapToLoadDataResult<Address>();
  }
}