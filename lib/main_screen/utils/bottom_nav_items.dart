import '../../components/config/app_images.dart';
import '../../gallery_screen/pages/gallery_page.dart';
import '../../home_screen/pages/home_page.dart';
import '../../profile_screen/pages/profile_page.dart';

final List<Map<String, dynamic>> bottomNavItems = [
  {
    "title": "Home",
    "screen": const HomePage(),
    "image": AppImages.instance.homePng,
  },
  {
    "title": "Daily Log",
    "screen": const HomePage(),
    "image": AppImages.instance.calculatorPng,
  },
  {
    "title": "Gallery",
    "screen": const GalleryPage(),
    "image": AppImages.instance.galleryPng,
  },
  {
    "title": "Profile",
    "screen": const ProfilePage(),
    "image": AppImages.instance.personPng,
  },
];
