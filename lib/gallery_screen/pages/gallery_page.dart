import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../../components/config/app_localization.dart';
import '../../components/utils/role_helper.dart';
import '../../components/widget/app_bar.dart';
import '../model/jewelry_model.dart';
import '../widget/category_buttons.dart';
import '../widget/gallery_bottom_sheet.dart';
import 'gallery_fetch_bloc.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  GalleryPageState createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {
  Map<String, dynamic> _data = {};
  List<JewelryItem> _currentItems = [];
  String _selectedCategory = 'all';
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadJsonData();
    _checkAdminRole();
  }

  Future<void> _loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/json/gallery_category_item.json');
    setState(() {
      _data = json.decode(jsonString);
      _currentItems = _getItems('gold');
    });
  }

  Future<void> _checkAdminRole() async {
    _isAdmin = await RoleHelper.isUserAdmin();
    setState(() {});
  }

  List<JewelryItem> _getItems(String category) {
    List<JewelryItem> items = [];
    if (_data.containsKey(category)) {
      for (var item in _data[category]['items'][0].entries) {
        items.add(JewelryItem(item.value));
      }
    }
    return items;
  }

  void _onChipSelected(String category) {
    setState(() {
      _selectedCategory = category;
      _currentItems = _getItems(category);
    });

    if (category != 'all') {
      _showBottomSheet();
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GalleryBottomSheet(
          currentItems: _currentItems,
          onCancel: () {
            Navigator.pop(context);
          },
          onFilter: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: AppLocalizations.of(context)!.translate("gallery"),
      ),
      body: Column(
        children: [
          CategoryButtons(
            selectedCategory: _selectedCategory,
            onCategorySelected: _onChipSelected,
          ),
          const Expanded(
            child: GalleryFetchBloc(),
          )
        ],
      ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              onPressed: () {
                // Admin action
              },
              tooltip: 'Add Item',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
