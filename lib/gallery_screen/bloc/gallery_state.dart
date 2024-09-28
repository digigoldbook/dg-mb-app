part of 'gallery_bloc.dart';

sealed class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

final class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final GalleryModel gallery;

  const GalleryLoaded({
    required this.gallery,
  });

  @override
  List<Object> get props => [gallery];
}

class GalleryError extends GalleryState {
  final String error;

  const GalleryError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
