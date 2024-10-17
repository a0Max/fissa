import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/details_of_transports_goods/presentation/manager/manager_of_transport_goods.dart';
import '../../features/home/data/data_sources/home_data_sources.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/repositories_home.dart';
import '../../features/home/domain/use_cases/get_home_data_use_cases.dart';
import '../../features/map_address/data/data_sources/search_about_location_information.dart';
import '../../features/map_address/data/repositories/map_repository_impl.dart';
import '../../features/map_address/domain/repositories/repositories_map.dart';
import '../../features/map_address/domain/use_cases/map_information_use_cases.dart';
import '../../features/map_address/presentation/manager/map_information.dart';
import '../apis_connections/api_connection.dart';
import '../network/network_info.dart';

part 'injection_import.dart';
