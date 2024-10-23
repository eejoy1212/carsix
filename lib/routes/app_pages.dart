import 'package:carsix/modules/favorite/bindings/favorite_binding.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/modules/favorite/views/favorite_view.dart';
import 'package:carsix/modules/goodbye/bindings/goodbye_binding.dart';
import 'package:carsix/modules/goodbye/views/goodbye_view.dart';
import 'package:carsix/modules/main/bindings/main_binding.dart';
import 'package:carsix/modules/main/views/main_view.dart';
import 'package:carsix/modules/loading/bindings/loading_binding.dart';
import 'package:carsix/modules/loading/views/loading_view.dart';
import 'package:carsix/modules/music_color/bindings/music_color_binding.dart';
import 'package:carsix/modules/music_color/views/music_color_view.dart';
import 'package:carsix/modules/welcome/bindings/welcome_binding.dart';
import 'package:carsix/modules/welcome/views/welcome_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/loading';

  static final routes = [
    GetPage(
      name: '/loading',
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: '/main',
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/favorite',
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: '/music-color',
      page: () => MusicColorView(),
      binding: MusicColorBinding(),
    ),
    GetPage(
      name: '/welcome',
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: '/goodbye',
      page: () => GoodbyeView(),
      binding: GoodbyeBinding(),
    ),
  ];
}
