
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../screens/detail/detail_view.dart';
import 'package:get/get.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
      title: Text(user.firstName + " " + user.lastName),
      subtitle: Text(user.email),
      onTap: () => Get.to(() => DetailView(user: user)),
    );
  }
}
