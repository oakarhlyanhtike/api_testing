import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:testing_api/model/task_model.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'http://jsonplaceholder.typicode.com/')
abstract class ApiService {

  
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  @GET('photos')
  Future<List<TaskModel>> getTasks();
}
