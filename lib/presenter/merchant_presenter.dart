import 'package:csi5112_project/data/merchant_data.dart';

import '../injection/dependency_injection_merchant.dart';

abstract class MerchantListViewContract {
  void onLoadMerchantsComplete(List<Merchant> merchants);

  void onLoadMerchantsError();
}

class MerchantListPresenter {
  late MerchantListViewContract view;
  late MerchantRepository repository;

  MerchantListPresenter(this.view) {
    repository = Injector().merchantRepository;
  }

  void loadItems() {
    assert(view != null);

    repository
        .fetch()
        .then((merchants) => view.onLoadMerchantsComplete(merchants))
        .catchError((onError) => view.onLoadMerchantsError());
  }
}
