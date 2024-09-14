import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../components/animation/fade_animation.dart';
import '../../components/widget/txt_widget.dart';
import '../utils/category_item.dart';
import '../widget/gallery_chip_widget.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
    with TickerProviderStateMixin {
  String _selectedValue = "Gold";
  late List<Map<String, String>>? _filteredItems;
  late FadeAnimation fadeAnimation;

  @override
  void initState() {
    _filteredItems = categoryItem[_selectedValue];
    fadeAnimation = FadeAnimation(this);
    fadeAnimation.start();
    super.initState();
  }

  @override
  void dispose() {
    _filteredItems!.clear();
    fadeAnimation.dispose();
    super.dispose();
  }

  void _changeListItem(String value) {
    setState(() {
      _selectedValue = value;
      _filteredItems = categoryItem[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categoryItem.keys.length, (index) {
              String key = categoryItem.keys.elementAt(index);
              return GalleryChipWidget(
                label: key,
                avatar: _selectedValue == key
                    ? const Icon(Icons.check)
                    : const SizedBox.shrink(),
                onPressed: () => _changeListItem(key),
              );
            }),
          ),
        ),

        // Category Selection Container
        Container(
          margin: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TxtWidget(
                strText: "Category : ",
                style: TxtStyle.md,
              ),
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredItems!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredItems![index]['title']!),
                      );
                    },
                  ),
                ),
                icon: const Icon(
                  Icons.tune,
                ),
              ),
            ],
          ),
        ),

        // Masonry Grid View
        Expanded(
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: 10, // Use the filtered items count
            itemBuilder: (context, index) {
              return FadeTransition(
                opacity: fadeAnimation.animation,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://plus.unsplash.com/premium_photo-1683140621573-233422bfc7f1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwZmFjZXxlbnwwfHwwfHx8MA%3D%3D",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
