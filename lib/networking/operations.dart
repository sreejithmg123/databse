import 'dart:convert';
import 'dart:io';

import 'package:databse/models/employee.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future fetchData() async {
    var responseJson;
    try {
      final response = await http
          .post(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

      if (response.statusCode == 200) {
        print(response.body);

        var jsonData = jsonDecode(response.body);
        return employeeFromJson(response.body);
      }
    } on SocketException {
      'No Internet connection';
    }
  }
}
