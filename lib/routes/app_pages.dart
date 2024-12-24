import 'package:carsix/content/mode/active_mode.dart';
import 'package:carsix/content/page/custom_color_setting.dart';
import 'package:carsix/content/page/custom_setting.dart';
import 'package:carsix/content/page/music_setting.dart';
import 'package:carsix/modules/color/bindings/custom_color_binding.dart';
import 'package:carsix/modules/color/views/custom_color_view.dart';
import 'package:carsix/modules/favorite/bindings/favorite_binding.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/modules/favorite/views/favorite_view.dart';
import 'package:carsix/modules/goodbye/bindings/goodbye_binding.dart';
import 'package:carsix/modules/goodbye/views/goodbye_view.dart';
import 'package:carsix/modules/loading/views/aos_info.dart';
import 'package:carsix/modules/main/bindings/main_binding.dart';
import 'package:carsix/modules/main/views/device_edit_view.dart';
import 'package:carsix/modules/main/views/main_view.dart';
import 'package:carsix/modules/loading/bindings/loading_binding.dart';
import 'package:carsix/modules/loading/views/loading_view.dart';
import 'package:carsix/modules/color/bindings/music_color_binding.dart';
import 'package:carsix/modules/color/views/music_color_view.dart';
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
      name: '/bg-color',
      page: () => CustomColorView(),
      binding: CustomColorBinding(),
    ),
    GetPage(
      name: '/custom1',
      page: () => CustomColorView(),
      binding: CustomColorBinding(),
    ),
    GetPage(
      name: '/custom2',
      page: () => CustomColorView(),
      binding: CustomColorBinding(),
    ),
    GetPage(
      name: '/custom3',
      page: () => CustomColorView(),
      binding: CustomColorBinding(),
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
    GetPage(
      name: '/device-edit',
      page: () => DeviceEditView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/active-mode',
      page: () => ActiveModeContent(),
      binding: MainBinding(),
    ),
    GetPage(name: '/music-setting', page: () => MusicSetting()),
    GetPage(
      name: '/aos-info',
      page: () => AosInfo(),
    ),
    GetPage(name: '/custom-setting', page: () => CustomSetting()),
    GetPage(name: '/custom-color-setting', page: () => CustomColorSetting()),
  ];
}
