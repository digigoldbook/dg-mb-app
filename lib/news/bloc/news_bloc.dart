import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/news_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<ListNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final response = await NewsService().fetchNews();
        final data = response.data;
        if (response.statusCode == 200) {
          emit(NewsSuccess(
            data: data,
          ));
        }
      } catch (error) {
        emit(NewsError(error: "$error"));
      }
    });
  }
}
