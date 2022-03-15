import '../data/product_data.dart';
import '../Injection/dependency_injection.dart';
import '../data/http_data.dart';

abstract class ProductsListViewContract {
  void onLoadProductsComplete(List<Product> products);

  void onLoadProductsError(onError);
}

class ProductsListPresenter {
  ProductsListViewContract view;
  late ProductRepository repository;

  ProductsListPresenter(this.view) {
    repository = Injector().productRepository;
  }

  void loadProducts(HttpRequest request) {
    repository
      .fetch(request)
      .then((products) => view.onLoadProductsComplete(products))
      .catchError((onError) => view.onLoadProductsError(onError));
  }
}