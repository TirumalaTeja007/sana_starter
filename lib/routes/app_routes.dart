part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const introduction = _Paths.introduction;
  static const settings = _Paths.settings;
  static const history = _Paths.history;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const introduction = '/';
  static const settings = '/Settings';
  static const history = '/History';
}
