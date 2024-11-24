import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../../../core/main_map_informations.dart';
import '../../domain/entities/predictions_model.dart';

abstract class DataSourceRemotelyOfSearchLocal {
  Future<List<String>?> getLocalTextSearch();
  Future<void> saveTextLocal({required String text});
}

class DataSourceRemotelyOfSearchLocalImpl
    implements DataSourceRemotelyOfSearchLocal {
  final MainApiConnection dio;

  DataSourceRemotelyOfSearchLocalImpl({required this.dio});

  @override
  Future<List<String>?> getLocalTextSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? x = prefs.getStringList('local_search');
    return x;
  }

  @override
  Future<void> saveTextLocal({required String text}) async {
    print('saveTextLocal:$text');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> data = prefs.getStringList('local_search') ?? [];
      data.add(text);
      List<String> data1 = data.sublist(0, data.length > 5 ? 5 : data.length);
      prefs.setStringList('local_search', data1);
    } catch (e) {
      print('error:$e');
    }
  }
}
