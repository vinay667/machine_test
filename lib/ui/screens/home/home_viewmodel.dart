
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

class HomeViewModel extends GetxController {
  final UserRepository repo;

  HomeViewModel(this.repo);

  var users = <UserModel>[].obs;
  var filtered = <UserModel>[].obs;

  var loading = false.obs;
  var hasMore = true.obs;

  int skip = 0;
  final limit = 10;
  String? gender;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  void fetch({bool refresh = false}) async {
    if (loading.value) return;

    loading.value = true;

    if (refresh) {
      skip = 0;
      users.clear();
      hasMore.value = true;
    }

    final data = await repo.fetchUsers(skip: skip,limit:  limit, gender: gender);

    if (data.isEmpty) {
      hasMore.value = false;
    } else {
      users.addAll(data);
      filtered.assignAll(users);
      skip += limit;
    }

    loading.value = false;
  }

  void search(String q) {
    filtered.assignAll(users.where((u) =>
        u.firstName.toLowerCase().contains(q.toLowerCase()) ||
        u.lastName.toLowerCase().contains(q.toLowerCase())));
  }

  void sortAZ() => filtered.sort((a, b) => a.firstName.compareTo(b.firstName));
  void sortZA() => filtered.sort((a, b) => b.firstName.compareTo(a.firstName));

  void filterGender(String g) {
    gender = g;
    fetch(refresh: true);
  }
}
