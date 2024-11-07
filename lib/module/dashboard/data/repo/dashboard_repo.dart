import 'dart:developer';

import 'package:evermos_test1/module/dashboard/data/model/pexels_photo_response.dart';
import 'package:evermos_test1/module/dashboard/data/service/pexels_api_service.dart';

mixin DashboardRepo {
  final _pexelsService = PexelsApiService();

  Future<PexelsPhotosResponse> repoGetPhoto({required int page}) async {
    try {
      final data = await _pexelsService.getPhoto(page: page);

      return PexelsPhotosResponse.fromJson(data);
    } catch (e) {
      log('Error Response getPhotos ::::: $e');
      rethrow;
    }
  }
}