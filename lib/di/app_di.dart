import 'package:flutter_notepad/di/app_di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => $initGetIt(getIt);
