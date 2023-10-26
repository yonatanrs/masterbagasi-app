import '../domain/entity/delivery/country_delivery_review_based_country_parameter.dart';
import '../domain/entity/delivery/country_delivery_review_response.dart';
import '../domain/usecase/get_country_delivery_review_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class CountryDeliveryReviewController extends BaseGetxController {
  final GetCountryDeliveryReviewUseCase getCountryDeliveryReviewUseCase;
  CountryDeliveryReviewSubDelegate? _countryDeliveryReviewSubDelegate;

  CountryDeliveryReviewController(
    super.controllerManager,
    this.getCountryDeliveryReviewUseCase
  );

  Future<LoadDataResult<CountryDeliveryReviewResponse>> getCountryDeliveryReview(CountryDeliveryReviewBasedCountryParameter countryDeliveryReviewBasedCountryParameter) {
    return getCountryDeliveryReviewUseCase.execute(countryDeliveryReviewBasedCountryParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("country-delivery").value
    );
  }

  CountryDeliveryReviewController setCountryDeliveryReviewSubDelegate(CountryDeliveryReviewSubDelegate countryDeliveryReviewSubDelegate) {
    _countryDeliveryReviewSubDelegate = countryDeliveryReviewSubDelegate;
    return this;
  }
}

class CountryDeliveryReviewSubDelegate {}