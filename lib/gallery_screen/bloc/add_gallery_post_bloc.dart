import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_gallery_post_event.dart';
part 'add_gallery_post_state.dart';

class AddGalleryPostBloc
    extends Bloc<AddGalleryPostEvent, AddGalleryPostState> {
  AddGalleryPostBloc() : super(AddGalleryPostInitial()) {
    on<AddGalleryPostEvent>((event, emit) {});
  }
}
