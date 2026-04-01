
import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';

class DetailView extends StatelessWidget {
  final UserModel user;

  const DetailView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.image)),
            const SizedBox(height: 10),
            Text(user.firstName + " " + user.lastName),
            Text(user.email),
            Text(user.phone),
            Text("${user.city}, ${user.state}, ${user.country}"),
            Text("DOB: ${user.dob}"),
            Text("Age: ${user.age}")
          ]),
        ),
      ),
    );
  }
}