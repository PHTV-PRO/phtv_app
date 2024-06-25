import 'package:phtv_app/apis/api_config.dart';

class JobApi extends ApiConfig {
  JobApi(
      {super.module = 'general/job',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final getLatestJobs = JobApi(path: '', method: RequestMethod.get);
}