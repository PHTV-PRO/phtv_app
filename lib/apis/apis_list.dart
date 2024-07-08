import 'package:phtv_app/apis/api_config.dart';

class AuthApi extends ApiConfig {
  AuthApi(
      {super.module = 'general',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final login = AuthApi(path: '/login', method: RequestMethod.post);
}

class SearchApi extends ApiConfig {
  SearchApi(
      {super.module = 'general/search',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final search = SearchApi(path: '', method: RequestMethod.get);
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
  static final filterCompany = CompanyApi(path: '/search', method: RequestMethod.post);
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

class CandidateJobApi extends ApiConfig {
  CandidateJobApi(
      {super.module = 'candidate/job',
        required super.path,
        required super.method,
        super.isAuth = true});

  static final getViewedJobs = CandidateJobApi(path: '/viewed', method: RequestMethod.get);
  static final viewJob = CandidateJobApi(path: '/viewed', method: RequestMethod.post);
}

class LocationApi extends ApiConfig {
  LocationApi(
      {super.module = 'general/city_province',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final getLocationList = LocationApi(path: '', method: RequestMethod.get);
}

class IndustryApi extends ApiConfig {
  IndustryApi(
      {super.module = 'general/industry',
        required super.path,
        required super.method,
        super.isAuth = false});

  static final getIndustryList = IndustryApi(path: '', method: RequestMethod.get);
}