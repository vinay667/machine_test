
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<List<UserModel>> fetchUsers({
    required int skip,
    required int limit,
    String? gender,
  }) async {
    final data = await apiService.getUsers(
      skip: skip,
      limit: limit,
      gender: gender,
    );

    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
