class AppImages {
  static final AppImages _singleton = AppImages._internal();
  AppImages._internal();
  static AppImages get instance => _singleton;

  final String welcomeBackground = "assets/images/welcome/img.webp";

  final String homePng = "assets/images/main/home.png";
  final String calculatorPng = "assets/images/main/calculator.png";
  final String galleryPng = "assets/images/main/gallery.png";
  final String personPng = "assets/images/main/user.png";
  final String dashboardPng = "assets/images/main/dashboard.png";
  final String agendaPng = "assets/images/main/agenda.png";
}
