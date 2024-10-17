part of 'injection_container.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => MapInformation(mapInformationUseCases: sl()));

  //UseCase
  sl.registerLazySingleton(() => MapInformationUseCases(sl()));
  sl.registerLazySingleton(() => GetHomeDataUseCases(sl()));

  //Repository
  sl.registerLazySingleton<MapRepository>(
      () => LessonRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<DataSourceRemotelyOfLocations>(
      () => DataSourceRemotelyOfLocationsImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfHome>(
      () => DataSourceRemotelyOfHomeImpl(dio: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => MainApiConnection());
}
