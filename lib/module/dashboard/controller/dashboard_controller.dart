import 'dart:developer';

import 'package:evermos_test1/module/dashboard/data/model/pexels_photo_response.dart';
import 'package:evermos_test1/module/dashboard/data/repo/dashboard_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController with DashboardRepo {
  final dashboardLoading = false.obs;
  final loadmoreLoading = false.obs;

  final isGridView = false.obs;

  List<Photos> listPhoto = <Photos>[].obs;

  final page = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData() async {
    listPhoto.clear();
    dashboardLoading.value = true;
    try {
      final response = await repoGetPhoto(page: page.value);
      if ((response.photos ?? []).isNotEmpty) {
        listPhoto.addAll(response.photos ?? []);
      }
      log('list photo : $listPhoto');
      dashboardLoading.value = false;
      page.value++;
    } catch (e) {
      print(e);
      dashboardLoading.value = true;
    }
  }

  void changeView(bool value) {
    isGridView.value = value;
  }

  Future<void> scrollCondition(ScrollNotification notif) async {
    final pixel = notif.metrics.pixels;
    final maxpixel = (notif.metrics.maxScrollExtent) * .9;
    // log("ini berapa pixel nya $pixel");
    // log("ini berapa maxpixelnya $maxpixel");
    if (pixel > maxpixel) {
      if (!loadmoreLoading.value) {
        loadmoreData();
      }
    }
  }

  Future<void> loadmoreData() async {
    loadmoreLoading.value = true;
    try {
      final response = await repoGetPhoto(page: page.value);
      if ((response.photos ?? []).isNotEmpty) {
        listPhoto.addAll(response.photos ?? []);
      }
      page.value++;
      loadmoreLoading.value = false;
    } catch (e) {
      print(e);
      loadmoreLoading.value = true;
    }
  }
}
