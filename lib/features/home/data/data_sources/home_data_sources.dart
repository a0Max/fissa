import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../domain/entities/home_model.dart';

abstract class DataSourceRemotelyOfHome {
  Future<HomeModel> getHomeDataRemotely();
}

class DataSourceRemotelyOfHomeImpl implements DataSourceRemotelyOfHome {
  final MainApiConnection dio;

  DataSourceRemotelyOfHomeImpl({required this.dio});

  @override
  Future<HomeModel> getHomeDataRemotely() async {
    final response =
        await dio.get(url: '${Connection.baseURL}${dio.homeEndPoint}');
    if (dio.validResponse(response)) {
      return HomeModel.fromJson(response.data['data']);
    } else {
      throw response.data['msg'];
    }
  }
}
