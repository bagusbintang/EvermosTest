import 'package:evermos_test1/common/services/pexels_client.dart';

class PexelsApiService {
  Future<Map<String, dynamic>> getPhoto({required int page}) async {
    try {
      final res = await PexelsClient.get(
        path:
            '/search?&query=nature&page=$page&per_page=10',
        // url: 'https://api.themoviedb.org/3/movie/now_playing?api_key=b8903b791ab75fc18a3ec0b368f333b2&language=en-US&page=1',
      );

      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}