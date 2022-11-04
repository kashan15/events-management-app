import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/app_language.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String? environment}) async{
  g.registerLazySingleton<MainViewModel>(() => MainViewModel());
  g.registerLazySingleton<AppLanguage>(() => AppLanguage());
}

Future<void> $initGetItAppLanguage(GetIt g, {String? environment}) async{
  g.registerLazySingleton<AppLanguage>(() => AppLanguage());
}