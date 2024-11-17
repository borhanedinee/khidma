import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';

class MyDrawerController extends GetxController {
  Widget currentPage = HomePage();
  changeCurrentPage(page){
    currentPage = page;
    update();
  }

  String selectedDrawerItem = 'H O M E';
  changeSelectedDrawerItem(label){
    selectedDrawerItem = label;
    update();
  }
}