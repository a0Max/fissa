part of 'injection_container.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => MapInformation(mapInformationUseCases: sl()));

  //UseCase
  sl.registerLazySingleton(() => MapInformationUseCases(sl()));

  //Repository
  sl.registerLazySingleton<MapRepository>(
      () => LessonRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<DataSourceRemotelyOfLocations>(
      () => DataSourceRemotelyOfLocationsImpl(dio: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => MainApiConnection());
}
