import '../../../domain/entity/address/add_address_parameter.dart';
import '../../../domain/entity/address/add_address_response.dart';
import '../../../domain/entity/address/address.dart';
import '../../../domain/entity/address/address_based_id_parameter.dart';
import '../../../domain/entity/address/address_list_parameter.dart';
import '../../../domain/entity/address/address_paging_parameter.dart';
import '../../../domain/entity/address/change_address_parameter.dart';
import '../../../domain/entity/address/change_address_response.dart';
import '../../../domain/entity/address/country.dart';
import '../../../domain/entity/address/country_list_parameter.dart';
import '../../../domain/entity/address/country_paging_parameter.dart';
import '../../../domain/entity/address/current_selected_address_parameter.dart';
import '../../../domain/entity/address/current_selected_address_response.dart';
import '../../../domain/entity/address/remove_address_parameter.dart';
import '../../../domain/entity/address/remove_address_response.dart';
import '../../../domain/entity/address/update_current_selected_address_parameter.dart';
import '../../../domain/entity/address/update_current_selected_address_response.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class AddressDataSource {
  FutureProcessing<CurrentSelectedAddressResponse> currentSelectedAddress(CurrentSelectedAddressParameter currentSelectedAddressParameter);
  FutureProcessing<PagingDataResult<Address>> addressPaging(AddressPagingParameter addressPagingParameter);
  FutureProcessing<List<Address>> addressList(AddressListParameter addressListParameter);
  FutureProcessing<UpdateCurrentSelectedAddressResponse> updateCurrentSelectedAddress(UpdateCurrentSelectedAddressParameter updateCurrentSelectedAddressParameter);
  FutureProcessing<List<Country>> countryList(CountryListParameter countryListParameter);
  FutureProcessing<PagingDataResult<Country>> countryPaging(CountryPagingParameter countryPagingParameter);
  FutureProcessing<AddAddressResponse> addAddress(AddAddressParameter addAddressParameter);
  FutureProcessing<ChangeAddressResponse> changeAddress(ChangeAddressParameter changeAddressParameter);
  FutureProcessing<RemoveAddressResponse> removeAddress(RemoveAddressParameter removeAddressParameter);
  FutureProcessing<Address> addressBasedId(AddressBasedIdParameter addressBasedIdParameter);
}