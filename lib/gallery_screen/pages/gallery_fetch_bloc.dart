import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gallery_bloc.dart';

class GalleryFetchBloc extends StatelessWidget {
  const GalleryFetchBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        if (state is GalleryInitial) {
          context.read<GalleryBloc>().add(FetchGalleryEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (state is GalleryLoaded) {
          return ListView.builder(
            itemCount: state.gallery.data!.length,
            itemBuilder: (context, index) {
              final item = state.gallery.data![index];
              return ListTile(
                title: Text(item.postTitle.toString()),
                subtitle: Text(item.stock.toString()),
              );
            },
          );
        } else if (state is GalleryError) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text('Press the button to fetch gallery.'));
      },
    );
  }
}
