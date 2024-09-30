import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../news/bloc/news_bloc.dart';
import '../../news/pages/news_detail_page.dart';

class HomeNewsWidgets extends StatelessWidget {
  const HomeNewsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            context.read<NewsBloc>().add(ListNewsEvent());
          }
          if (state is NewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsSuccess) {
            final data = state.data;
            return Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> item = data[index];
                    return ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(
                            data: item,
                          ),
                        ),
                      ),
                      leading: Image.network(
                        item['jetpack_featured_media_url'],
                      ),
                      title: Text(item['title']['rendered']),
                    );
                  }),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
