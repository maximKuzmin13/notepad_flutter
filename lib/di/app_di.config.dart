// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../domain/NoteRepository.dart' as _i3;
import '../presentation/NoteViewModel.dart' as _i5;
import 'app_module.dart' as _i6;
import 'note_module.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  final noteModule = _$NoteModule();
  gh.factory<_i3.NoteRepository>(
      () => noteModule.provideNoteRepository(get<_i4.Dio>()));
  gh.factory<_i5.NoteViewModel>(
      () => noteModule.provideNoteViewModel(get<_i3.NoteRepository>()));
  gh.singleton<_i4.Dio>(appModule.provideDio());
  return get;
}

class _$AppModule extends _i6.AppModule {}

class _$NoteModule extends _i7.NoteModule {}
