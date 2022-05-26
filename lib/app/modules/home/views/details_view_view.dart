import 'package:databse/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailsViewView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Image.network(
              controller.image.value,
              height: 80,
              width: 80,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          returnData(title: 'Name', value: controller.name.value),
          SizedBox(
            height: 10,
          ),
          returnData(title: 'User Name', value: controller.userName.value),
          SizedBox(
            height: 10,
          ),
          returnData(title: 'Email', value: controller.email.value),
          SizedBox(
            height: 10,
          ),
          returnData(title: 'Phone', value: controller.phone.value),
        ],
      )),
    );
  }

  returnData({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(value ?? '')
        ],
      ),
    );
  }
}
