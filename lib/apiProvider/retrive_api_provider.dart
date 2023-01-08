import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/reference_response.dart';
import 'package:icon/response/ret_details_response.dart';
import 'package:icon/response/ret_purchases_response.dart';
import 'package:icon/response/retrive_reponse.dart';
import 'package:dio/dio.dart' as dio;
import 'package:icon/response/returnpur_response.dart';

import 'package:icon/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RetriveApiProvider {
  Dio _dio = Dio();

  RetriveApiProvider() {
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

  Future<RetriveResponse> getRetriveSale(Map<String, dynamic> data,FormData dataMap) async {
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
        options.headers["Accept"] = '*/*';
        options.headers["Cookie"] = aToken! +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token!;
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Sales/return_sale';
      response = await _dio.post(
        url,queryParameters:  data,
        data:  dataMap
      );
      print(response);

      return RetriveResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return RetriveResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }
  Future<ReferenceResponse> getRetriveList(Map<String, dynamic> data,FormData dataMap) async {
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
        options.headers["Accept"] = '*/*';
        options.headers["Cookie"] = aToken! +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token!;
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Sales/SuggestionsInvoice';
      print(url);
      response = await _dio.get(
          url,queryParameters:  data,
      );
      print(response);

      return ReferenceResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReferenceResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }
  Future<REturnPurchasesREsponse> getRetriveListPurchases(Map<String, dynamic> data,FormData dataMap) async {
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
        options.headers["Accept"] = '*/*';
        options.headers["Cookie"] = aToken! +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token!;
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Purchases/SuggestionsInvoice';
      print(url);
      response = await _dio.get(
        url,queryParameters:  data,
      );
      print(response);

      return REturnPurchasesREsponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return REturnPurchasesREsponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }

  Future<AddCustomerResponse> AddReturns(dio.FormData data,    Map<String, dynamic> dataId) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');
    String? aToken = prefs.getString('aToken');
    String lastT = aToken! +
        '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
        token!;
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;
        options.headers["Content-Type"] = 'application/json';

        options.headers["Cookie"] = aToken +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token;

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
      String url = BASEURL! + AppConstants.BASE_URL + 'Sales/return_sale';

      print(url);
      response = await _dio.post(
          url,data: data,queryParameters: dataId
      );
      print(response);
      return AddCustomerResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return AddCustomerResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<ReturnPurResponse> AddReturnsPur(dio.FormData data,    Map<String, dynamic> dataId) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');
    String? aToken = prefs.getString('aToken');
    String lastT = aToken! +
        '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
        token!;
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;
        options.headers["Content-Type"] = 'application/json';

        options.headers["Cookie"] = aToken +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token;

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
      String url = BASEURL! + AppConstants.BASE_URL + 'Purchases/return_purchase';

      print(url);
      response = await _dio.post(
        url,data: data,queryParameters: dataId
      );
      print(response);
      return ReturnPurResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ReturnPurResponse.withError(e.response!.data);
    }
  }
  Future<REtPurchasesDetails> getPurDetails(FormData dataMap) async {
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
        options.headers["Accept"] = '*/*';
        options.headers["Cookie"] = aToken! +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token!;
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Purchases/return_purchase';
      response = await _dio.post(
          url,
          data:  dataMap
      );
      print(response);

      return REtPurchasesDetails.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return REtPurchasesDetails.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }


}
