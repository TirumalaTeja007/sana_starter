part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const introduction = _Paths.introduction;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const introduction = '/';
}
