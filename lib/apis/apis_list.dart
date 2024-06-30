import 'package:phtv_app/apis/api_config.dart';

class AuthApi extends ApiConfig {
  AuthApi(
      {super.module = 'general',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final login = AuthApi(path: '/login', method: RequestMethod.post);
}

class CompanyApi extends ApiConfig {
  CompanyApi(
      {super.module = 'general/company',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final getAllCompanies = CompanyApi(path: '', method: RequestMethod.get);
  static final getCompanyDetail = CompanyApi(path: '', method: RequestMethod.get);
  static final getContractCompany = CompanyApi(path: '/contract', method: RequestMethod.get);
  static final getSpotlightCompany = CompanyApi(path: '/application_most', method: RequestMethod.get);
}

class JobApi extends ApiConfig {
  JobApi(
      {super.module = 'general/job',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final getLatestJobs = JobApi(path: '', method: RequestMethod.get);
  static final getJobDetail = JobApi(path: '', method: RequestMethod.get);
}