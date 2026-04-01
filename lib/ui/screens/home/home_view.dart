
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme_controller.dart';
import 'home_viewmodel.dart';
import '../../widgets/user_tile.dart';

class HomeView extends StatelessWidget {
  final homeController = Get.find<HomeViewModel>();
  final scroll = ScrollController();

  HomeView({super.key}) {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        homeController.fetch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users"), actions: [
        IconButton(onPressed: homeController.sortAZ, icon: const Icon(Icons.arrow_upward)),
        IconButton(
            onPressed: homeController.sortZA, icon: const Icon(Icons.arrow_downward)),


        GetX<ThemeController>(
          builder: (themeController) {
            return IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: themeController.toggleTheme,
            );
          },
        ),
      ],



      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(onChanged: homeController.search,
              decoration: const InputDecoration(hintText: "Search")),
        ),
        Row(children: [
          TextButton(onPressed: () => homeController.filterGender("male"),
              child: const Text("Male")),
          TextButton(onPressed: () => homeController.filterGender("female"),
              child: const Text("Female")),
        ]),
        Expanded(child: Obx(() {
          if (homeController.loading.value && homeController.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async => homeController.fetch(refresh: true),
            child: ListView.builder(
              controller: scroll,
              itemCount: homeController.filtered.length + 1,
              itemBuilder: (_, i) {
                if (i < homeController.filtered.length) {
                  return UserTile(user: homeController.filtered[i]);
                }
                return homeController.hasMore.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              },
            ),
          );
        }))
      ]),
    );
  }
}