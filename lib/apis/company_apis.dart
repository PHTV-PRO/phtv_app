import 'package:phtv_app/apis/api_config.dart';

class CompanyApi extends ApiConfig {
  CompanyApi(
      {super.module = 'general/company',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final getAllCompanies = CompanyApi(path: '', method: RequestMethod.get);
}