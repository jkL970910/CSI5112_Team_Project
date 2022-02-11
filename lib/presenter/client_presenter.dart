import 'package:csi5112_project/data/client_data.dart';
import 'package:csi5112_project/injection/dependency_injection_client.dart';

abstract class UserListViewContract {
  void onLoadUserComplete(List<User> users);

  void onLoadUserError();
}

class UserListPresenter {
  UserListViewContract view;
  late UserRepository repository;

  UserListPresenter(this.view) {
    repository = Injector().userRepository as UserRepository;
  }

  void loadItems() {
    assert(view != null);

    repository
        .fetch()
        .then((users) => view.onLoadUserComplete(users))
        .catchError((onError) => view.onLoadUserError());
  }
}
