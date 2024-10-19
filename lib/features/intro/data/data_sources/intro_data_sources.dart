import '../../../../../core/apis_connections/api_connection.dart';
import '../../../../../core/connection.dart';
import '../../domain/entities/get_stuff_types_model.dart';
import '../../domain/entities/main_app_required.dart';
import '../../domain/entities/user_data_model.dart';

abstract class DataSourceRemotelyOfIntro {
  Future<UserData> getUserDataRepository();
  Future<MainAppRequiredModel> getStuffTypesDataRepository();
}

class DataSourceRemotelyOfIntroImpl implements DataSourceRemotelyOfIntro {
  final MainApiConnection dio;

  DataSourceRemotelyOfIntroImpl({required this.dio});

  @override
  Future<MainAppRequiredModel> getStuffTypesDataRepository() async {
    final response =
        await dio.get(url: '${Connection.baseURL}${dio.getStuffTypesEndPoint}');
    if (dio.validResponse(response)) {
      // final List<GetStuffTypesModel> l = [];
      // response.data['data']
      //     .forEach((e) => l.add(GetStuffTypesModel.fromJson(e)));
      return MainAppRequiredModel.fromJson(response.data['data']);
    } else {
      throw response.data['msg'];
    }
  }

  @override
  Future<UserData> getUserDataRepository() async {
    final response =
        await dio.get(url: '${Connection.baseURL}${dio.userEndPoint}');
    if (dio.validResponse(response)) {
      return UserData.fromJson(response.data['data']);
    } else {
      throw response.data['msg'];
    }
  }
}
