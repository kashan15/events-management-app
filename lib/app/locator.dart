import 'package:democratic_unity/app/locator.iconfig.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;
@injectableInit
Future<void> configure() => $initGetIt(locator);