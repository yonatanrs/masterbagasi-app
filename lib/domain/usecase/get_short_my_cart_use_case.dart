import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/cart.dart';
import '../entity/cart/cart_paging_parameter.dart';
import '../repository/cart_repository.dart';

class GetShortMyCartUseCase {
  final CartRepository cartRepository;

  const GetShortMyCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<List<Cart>>> execute() {
    return cartRepository.cartPaging(
      CartPagingParameter(
        page: 1,
        itemEachPageCount: 10
      )
    ).map(
      onMap: (cartPagingDataResultLoadDataResult) {
        return cartPagingDataResultLoadDataResult.map<List<Cart>>((cartPagingDataResult) {
          return cartPagingDataResult.itemList;
        });
      }
    );
  }
}