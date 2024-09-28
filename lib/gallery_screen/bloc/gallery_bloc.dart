import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/gallery_model.dart';
import '../services/gallery_service.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository galleryRepository = GalleryRepository();

  GalleryBloc() : super(GalleryInitial()) {
    on<FetchGalleryEvent>((event, emit) async {
      emit(GalleryLoading());
      try {
        final gallery = await galleryRepository.fetchGallery();
        if (gallery != null) {
          emit(GalleryLoaded(gallery: gallery));
        } else {
          emit(const GalleryError(error: 'Failed to load gallery.'));
        }
      } catch (error) {
        emit(GalleryError(error: 'Error: $error'));
      }
    });
  }
}
