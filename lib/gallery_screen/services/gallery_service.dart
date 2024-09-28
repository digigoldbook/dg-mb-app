import 'package:flutter/material.dart';

import '../../components/utils/app_service.dart';
import '../model/gallery_model.dart';

class GalleryRepository {
  final HttpService httpService = HttpService();
  Future<GalleryModel?> fetchGallery() async {
    try {
      final response = await httpService.get('/gallery');
      if (response.statusCode == 200) {
        return GalleryModel.fromJson(response.data);
      } else {
        debugPrint('Failed to load gallery: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching gallery: $e');
    }
    return null;
  }
}
