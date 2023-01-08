import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/purchases_response.dart';

import 'package:icon/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchasesApiProvider {
  Dio _dio = Dio();

  PurchasesApiProvider() {
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
  Future<AddCustomerResponse> AddPurchase(FormData data) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Purchases/add';
      print(url);
      response = await _dio.post(
        url,
        data: data,
      );
      print(response);
      return AddCustomerResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return AddCustomerResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<PurchasesResponse> getPurList() async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'purchases';
      response = await _dio.get(
        url,
      );
      print(response);

      return PurchasesResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return PurchasesResponse.withError(
          e.response!.data, e.response!.statusCode!);
    }
  }
}
