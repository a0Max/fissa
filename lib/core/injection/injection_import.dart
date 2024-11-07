part of 'injection_container.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // bloc
  // sl.registerFactory(() => AuthProvider(
  //     getUserDataUseCases: sl(),
  //     getStuffTypesDataUseCases: sl(),
  //     addRequiredDataUseCases: sl(),
  //     checkOtpUseCases: sl(),
  //     loginUseCases: sl()));
  sl.registerFactory(() => MapInformation(
      mapInformationUseCases: sl(),
      getLocalSearchUseCases: sl(),
      saveLocalSearchUseCases: sl()));
  sl.registerFactory(() => HomeProvider(getHomeDataUseCases: sl()));
  sl.registerFactory(() => TripHistoryProvider(tripHistoryUseCases: sl()));
  sl.registerFactory(() => RateDriverProvider(rateTripUseCases: sl()));
  sl.registerFactory(() => CurrentTripProvider(
      locationService: sl(), cancelTripOfPullerUseCases: sl()));
  // sl.registerFactory(() => MapOfPullerProvider(
  //     createTripOfPullerUseCases: sl(),
  //     getPriceTripOfPullerUseCases: sl(),
  //     locationService: sl()));

  //UseCase
  sl.registerLazySingleton(() => CancelTripOfPullerUseCases(sl()));
  sl.registerLazySingleton(() => LogOutUseCases(sl()));
  sl.registerLazySingleton(() => ReOrderTripUseCases(sl()));
  sl.registerLazySingleton(() => UpdateUserDataUseCases(sl()));
  sl.registerLazySingleton(() => MapInformationUseCases(sl()));
  sl.registerLazySingleton(() => CreateTripOfPullerUseCases(sl()));
  sl.registerLazySingleton(() => GetPriceTripOfPullerUseCases(sl()));
  sl.registerLazySingleton(() => AddRequiredDataUseCases(sl()));
  sl.registerLazySingleton(() => CheckOtpUseCases(sl()));
  sl.registerLazySingleton(() => LoginUseCases(sl()));
  sl.registerLazySingleton(() => GetHomeDataUseCases(sl()));
  sl.registerLazySingleton(() => GetUserDataUseCases(sl()));
  sl.registerLazySingleton(() => GetStuffTypesDataUseCases(sl()));
  sl.registerLazySingleton(() => CreateTripOfTransportsGoodsUseCases(sl()));
  sl.registerLazySingleton(() => GetPriceTripOfTransportsGoodsUseCases(sl()));
  sl.registerLazySingleton(() => GetLocalSearchUseCases(sl()));
  sl.registerLazySingleton(() => SaveLocalSearchUseCases(sl()));
  sl.registerLazySingleton(() => RateTripUseCases(sl()));
  sl.registerLazySingleton(() => TripHistoryUseCases(sl()));

  //Repository
  sl.registerLazySingleton<IntroRepository>(
      () => IntroRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RepositoriesTripReOrder>(() =>
      TransportsReOrderRepositoryImpl(
          remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RepositoriesRateTrip>(
      () => RateRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RepositoriesTripOfPuller>(
      () => PullerRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginUpdateRepository>(() =>
      LoginUpdateRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RepositoriesTripOfTransportsGoods>(() =>
      TransportsGoodsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RepositoriesTripHistory>(() =>
      TripHistoryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<DataSourceRemotelyOfIntro>(
      () => DataSourceRemotelyOfIntroImpl(dio: sl()));
  sl.registerLazySingleton<ReorderTripDataSources>(
      () => DataSourceReorderTripImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfTripOfPuller>(
      () => DataSourceRemotelyOfTripOfPullerImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfSearchLocal>(
      () => DataSourceRemotelyOfSearchLocalImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfLoginUpdateData>(
      () => DataSourceRemotelyOfLoginUpdateImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfTripOfTransportsGoods>(
      () => DataSourceRemotelyOfTripOfTransportsGoodsImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfLocations>(
      () => DataSourceRemotelyOfLocationsImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfHome>(
      () => DataSourceRemotelyOfHomeImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfRateTrip>(
      () => DataSourceRemotelyOfRateTripImpl(dio: sl()));
  sl.registerLazySingleton<DataSourceRemotelyOfTripHistory>(
      () => DataSourceRemotelyOfTripHistoryImpl(dio: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => MainApiConnection());
}
