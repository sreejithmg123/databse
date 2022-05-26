import 'package:databse/app/modules/home/views/details_view_view.dart';
import 'package:databse/databse/databseHelper.dart';
import 'package:databse/models/employee.dart';
import 'package:databse/networking/operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  TextEditingController nameController = TextEditingController();
  RxBool isLoading = false.obs;
  List<Employee> employeeList = [];
  List<Employee> employeeDBList = [];
  RxString userName = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString image = ''.obs;
  RxString website = ''.obs;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  @override
  void onInit() {
    super.onInit();

    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> fetchData() async {
    isLoading(true);
    employeeDBList = await fetchDatdb();
    isLoading(false);
    if (employeeDBList.isEmpty || employeeDBList == null) {
      employeeList = await apiBaseHelper.fetchData();
      addItems();
    }
  }

  Future<List<Employee>> fetchDatdb() async {
    return await DatabaseHelper.instance.getEmployees();
  }

  Future addItems() async {
    isLoading(true);
    for (int i = 0; i < employeeList.length; i++) {
      await DatabaseHelper.instance.add(Employee(
          name: employeeList[i].name,
          id: employeeList[i].id,
          profileImage: employeeList[i].profileImage,
          username: employeeList[i].username,
          phone: employeeList[i].phone,
          email: employeeList[i].email,
          website: employeeList[i].website));
    }
    employeeDBList = await fetchDatdb();
    isLoading(false);
  }

  Future<void> searchEmployees(String name) async {
    isLoading(true);
    employeeDBList = await DatabaseHelper.instance.searchEmployee(name);
    isLoading(false);
  }

  goToDetailedView(Employee employee) {
    userName.value = employee.username ?? '';
    name.value = employee.name ?? '';
    phone.value = employee.phone ?? '';
    email.value = employee.email ?? '';
    image.value = employee.profileImage ??
        'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg';
    website.value = employee.website ?? '';
    Get.to(DetailsViewView());
  }
}
