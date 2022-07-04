import 'package:food_deliver/screen/login/service/login_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

setupLocator() {
  locator.registerLazySingleton(() => LoginService());
}
