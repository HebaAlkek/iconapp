import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/customer_details_response.dart';
import 'package:icon/response/customer_reponse.dart';
import 'package:icon/response/general_reponse.dart';
import 'package:icon/response/print_reponse.dart';
import 'package:icon/response/report_sale_response.dart';
import 'package:icon/response/report_taxs_response.dart';
import 'package:icon/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportApiProvider {
  Dio _dio = Dio();

  ReportApiProvider() {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      _dio.interceptors.requestLock.lock();

      _dio.interceptors.requestLock.unlock();
      //  options.headers["Content-Type"] = "application/json";
      return handler.next(options);
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response);
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e);
    }));
  }
  Future<PrintResponse> printReport(String reportId) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');
    String? aToken = prefs.getString('aToken');

    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;

        options.headers["Cookie"] = aToken!+
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token!;

        _dio.interceptors.requestLock.unlock();

        return handler.next(options);
      }, onResponse: (response, handler) {
        // Do something with response data

        return handler.next(response);
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e);
      }));
      final prefs = await SharedPreferences.getInstance();
      String? BASEURL = prefs.getString('baseurl');
      String url = BASEURL! + AppConstants.BASE_URL + 'Sales/print/'+reportId;
      print(url);
      response = await _dio.get(
        url,
      );
      print(response);
      return PrintResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return PrintResponse.withError(e.response!.data);
    }
  }

  Future<ReportTaxsResponse> getReportTaxs(String pageTax) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        options.headers["Accept"] = '*/*';

        options.headers["authorization"] = basicAuth;
        options.headers["Connection"] = 'keep-alive';

        return handler.next(options);
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e);
      }));

      final prefs = await SharedPreferences.getInstance();
      String? BASEURL = prefs.getString('baseurl');
      String url = BASEURL! + AppConstants.BASE_URL + 'Reports/get_sale_taxes?start='+pageTax;
      response = await _dio.get(
        url,
      );
      print(response);

      return ReportTaxsResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReportTaxsResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }
  Future<ReportTaxsResponse> getReportTaxsSearch(String pageTax,Map<String, dynamic> dataId) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        options.headers["Accept"] = '*/*';

        options.headers["authorization"] = basicAuth;
        options.headers["Connection"] = 'keep-alive';

        return handler.next(options);
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e);
      }));

      final prefs = await SharedPreferences.getInstance();
      String? BASEURL = prefs.getString('baseurl');
      String url = BASEURL! + AppConstants.BASE_URL + 'Reports/get_sale_taxes?start='+pageTax;
      response = await _dio.get(
        url,queryParameters: dataId
      );
      print(response);

      return ReportTaxsResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReportTaxsResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }

  Future<ReportTaxsResponse> getReportTaxp() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        options.headers["Accept"] = '*/*';

        options.headers["authorization"] = basicAuth;
        options.headers["Connection"] = 'keep-alive';

        return handler.next(options);
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e);
      }));

      final prefs = await SharedPreferences.getInstance();
      String? BASEURL = prefs.getString('baseurl');
      String url = BASEURL! + AppConstants.BASE_URL + 'Reports/get_purchase_taxes';
      response = await _dio.get(
        url,
      );
      print(response);

      return ReportTaxsResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReportTaxsResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }


  Future<ReportSaleResponse> getReportSale(String page) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        options.headers["Accept"] = '*/*';

        options.headers["authorization"] = basicAuth;
        options.headers["Connection"] = 'keep-alive';

        return handler.next(options);
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e);
      }));

      final prefs = await SharedPreferences.getInstance();
      String? BASEURL = prefs.getString('baseurl');
      String url = BASEURL! + AppConstants.BASE_URL + 'Reports/getSalesReport?start='+page;
      response = await _dio.get(
        url,
      );
      print(response);

      return ReportSaleResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReportSaleResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }
  Future<ReportSaleResponse> getReportSaleSearch(String page,Map<String, dynamic> dataId) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        options.headers["Accept"] = '*/*';

        options.headers["authorization"] = basicAuth;
        options.headers["Connection"] = 'keep-alive';

        return handler.next(options);
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e);
      }));

      final prefs = await SharedPreferences.getInstance();
      String? BASEURL = prefs.getString('baseurl');
      String url = BASEURL! + AppConstants.BASE_URL + 'Reports/getSalesReport?start='+page;
      response = await _dio.get(
        url,queryParameters: dataId
      );
      print(response);

      return ReportSaleResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReportSaleResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }

}
