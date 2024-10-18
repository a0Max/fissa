part of 'injection_container.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() =>
      AuthProvider(getUserDataUseCases: sl(), getStuffTypesDataUseCases: sl()));
  sl.registerFactory(() => MapInformation(mapInformationUseCases: sl()));
  sl.registerFactory(() => HomeProvider(getHomeDataUseCases: sl()));

  //UseCase
  sl.registerLazySingleton(() => MapInformationUseCases(sl()));
  sl.registerLazySingleton(() => GetHomeDataUseCases(sl()));
  sl.registerLazySingleton(() => GetUserDataUseCases(sl()));
  sl.registerLazySingleton(() => GetStuffTypesDataUseCases(sl()));
  sl.registerLazySingleton(() => CreateTripOfTransportsGoodsUseCases(sl()));

  //Repository
  sl.registerLazySingleton<IntroRepository>(
      () => IntroRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RepositoriesTripOfTransportsGoods>(() =>
      TransportsGoodsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MapRepository>(
      () => LessonRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<DataSourceRemotelyOfIntro>(
      () => DataSourceRemotelyOfIntroImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfTripOfTransportsGoods>(
      () => DataSourceRemotelyOfTripOfTransportsGoodsImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfLocations>(
      () => DataSourceRemotelyOfLocationsImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfHome>(
      () => DataSourceRemotelyOfHomeImpl(dio: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => MainApiConnection());
}
