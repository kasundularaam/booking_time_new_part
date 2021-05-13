import 'package:get_it/get_it.dart';

import 'contact_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(ContactService());
}
