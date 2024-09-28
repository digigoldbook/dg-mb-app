part of 'add_gallery_post_bloc.dart';

sealed class AddGalleryPostState extends Equatable {
  const AddGalleryPostState();
  
  @override
  List<Object> get props => [];
}

final class AddGalleryPostInitial extends AddGalleryPostState {}
