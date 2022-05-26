import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(
        () => controller.isLoading.value
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      onChanged: ((value) {
                        controller.searchEmployees(value);
                      }),
                      decoration: InputDecoration(
                          hintText: 'Enter Last letter of your name to search'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView(
                      children: controller.employeeDBList.map((e) {
                        return ListTile(
                          onTap: (() => controller.goToDetailedView(e)),
                          title: Text(e.name ?? ''),
                          subtitle: Text(e.username ?? ''),
                          leading: Image.network(e.profileImage ??
                              'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg'),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
              ),
      ),
    ));
  }
}
