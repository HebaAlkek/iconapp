import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as ge;
import 'package:icon/generated/l10n.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/cash_response.dart';
import 'package:icon/response/code_response.dart';
import 'package:icon/response/general_reponse.dart';
import 'package:icon/response/login_guest_response.dart';
import 'package:icon/response/logo_response.dart';
import 'package:icon/response/pos_response.dart';
import 'package:icon/response/product_details_response.dart';
import 'package:icon/response/product_response.dart';
import 'package:icon/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

String aToken = '';

class PosApiProvider {
  Dio _dio = Dio();

  PosApiProvider() {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      _dio.interceptors.requestLock.lock();

      options.headers["cookie"] = aToken;

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

  Future<AddCustomerResponse> addMainCat(FormData data) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/add_category';
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
  Future<AddCustomerResponse> editMainCat(FormData data,String catId) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'products/edit_category/'+catId;
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
  Future<AddCustomerResponse> editBrand(FormData data,String brandId) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'products/edit_brand/'+brandId;
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

  Future<AddCustomerResponse> deleteCat(String catId) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/delete_category/'+catId;
      print(url);
      response = await _dio.delete(
        url,
      );
      print(response);
      return AddCustomerResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return AddCustomerResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<AddCustomerResponse> addBrand(FormData data) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/add_brand';
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
  Future<AddCustomerResponse> deleteBrand(String brandId) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/delete_brand/'+brandId;
      print(url);
      response = await _dio.delete(
        url,
      );
      print(response);
      return AddCustomerResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return AddCustomerResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<PosResponse> getPosDefault(int page) async {
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
      String url =
          BASEURL! + AppConstants.BASE_URL + 'pos?start='+page.toString()+'&limit=10&include=brand,category';
      response = await _dio.get(
        url,
      );
      print(response);
      final cookies = response.headers.map['set-cookie'];

      if (cookies!.isNotEmpty && cookies.length == 2) {
        final authToken = cookies[1]
            .split(';')[0]; //it depends on how your server sending cookie
        //save this authToken in local storage, and pass in further api calls.

        aToken =
            authToken; //saving this to global variable to refresh current api calls to add cookie.
        print(authToken);
        prefs.setString('aToken', aToken);
      }
      return PosResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return PosResponse.withError(e.response!.data, e.response!.statusCode!);
    }
  }

  Future<PosResponse> checkAuth(String users, String pass) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$users:$pass'));
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
      String url =
          BASEURL! + AppConstants.BASE_URL + 'pos?include=brand,category';
      response = await _dio.get(
        url,
      );
      print(response);
      final cookies = response.headers.map['set-cookie'];

      if (cookies!.isNotEmpty && cookies.length == 2) {
        final authToken = cookies[1]
            .split(';')[0]; //it depends on how your server sending cookie
        //save this authToken in local storage, and pass in further api calls.

        aToken =
            authToken; //saving this to global variable to refresh current api calls to add cookie.
        print(authToken);
        prefs.setString('aToken', aToken);
      }
      return PosResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      String mes='';

      print("Exception occured: $e stackTrace");
      if(e.response!.data['error']=='Unauthorized'){
        final prefs = await SharedPreferences.getInstance();
int? count= prefs.getInt('countt');
if(count==null){
  prefs.setInt('countt',1);
  mes = S.of(ge.Get.context!).usersE;

}else{
  if(count<3){
    prefs.setInt('countt',count+1);
    mes = S.of(ge.Get.context!).usersE;

  }else{
    mes = S.of(ge.Get.context!).fail;
  }
}
      }
      return PosResponse.withError(mes, e.response!.statusCode!);
    }
  }

  Future<ProductResponse> getProduct(String categryCode) async {
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
        //  options.headers["Content-Type"] = 'application/json';
        options.headers["authorization"] = basicAuth;

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
      String url = BASEURL! +
          AppConstants.BASE_URL +
          'products?include=brand,category&start=1&limit=10000000&category_code=' +
          categryCode;

      response = await _dio.get(
        url,
      );
      print(response);
      return ProductResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ProductResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<ProductResponse> getAllProduct(String page) async {
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
        //  options.headers["Content-Type"] = 'application/json';
        options.headers["authorization"] = basicAuth;

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
      String url =
          BASEURL! + AppConstants.BASE_URL + 'products?include=brand,category&start='+page+'&limit=10';

      response = await _dio.get(
        url,
      );
      print(response);
      return ProductResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ProductResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }
  Future<ProductDetailsResponse> getDetailsProduct(String proId,FormData data) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');

    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        //  options.headers["Content-Type"] = 'application/json';
        options.headers["authorization"] = basicAuth;
        options.headers["Content-Type"] = 'application/json';

        options.headers["Cookie"] = aToken +
            '; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
            token!;

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
      String url =
          BASEURL! + AppConstants.BASE_URL + 'products/edit_Products/'+proId;
print(url);
      response = await _dio.post(
        url,data: data
      );
      print(response);
      return ProductDetailsResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ProductDetailsResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<ProductResponse> getProductByBrand(String brandCode) async {
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
        //  options.headers["Content-Type"] = 'application/json';
        options.headers["authorization"] = basicAuth;

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
      String url = BASEURL! +
          AppConstants.BASE_URL +
          'products?include=brand,category&start=1&limit=10000000&brand_code=' +
          brandCode;
      print(url);
      response = await _dio.get(
        url,
      );
      print(response);
      return ProductResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ProductResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<ProductResponse> getProductAllBrand() async {
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
        //  options.headers["Content-Type"] = 'application/json';
        options.headers["authorization"] = basicAuth;

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
      String url =
          BASEURL! + AppConstants.BASE_URL + 'products?include=brand,category&start=1&limit=10000000';
      print(url);
      response = await _dio.get(
        url,
      );
      print(response);
      return ProductResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ProductResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<ProductResponse> getProductByBSub(String subCode) async {
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
        //  options.headers["Content-Type"] = 'application/json';
        options.headers["authorization"] = basicAuth;

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
      String url = BASEURL! +
          AppConstants.BASE_URL +
          'products?include=brand,category&start=1&limit=10000000&subcategory_code=' +
          subCode;
      print(url);
      response = await _dio.get(
        url,
      );
      print(response);
      return ProductResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return ProductResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<CodeResponse> getProductByCode(String code) async {
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
        options.headers["authorization"] = basicAuth;

        //  options.headers["Content-Type"] = 'application/json';
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
      String url = BASEURL! +
          AppConstants.BASE_URL +
          'products?include=brand,category&start=1&limit=10000000&code=' +
          code;
      print(url);
      response = await _dio.get(
        url,
      );
      print(response);
      return CodeResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return CodeResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }

  Future<GeneralResponse> addSale(FormData data) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');

    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;

        options.headers["Cookie"] = aToken +
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
      String url = BASEURL! + AppConstants.BASE_URL + 'pos/add';
      print(url);
      response = await _dio.post(
        url,
        data: data,
      );
      print(response);
      return GeneralResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return GeneralResponse.withError(e.response!.data);
    }
  }
  Future<GuestResponse> loginGuest(FormData data) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');

    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;

        options.headers["Cookie"] = aToken +
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

      response = await _dio.post(
        'https://icon-pos.com/api/v1/pos/demo_request',
        data: data,
      );
      print(response);
      return GuestResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return GuestResponse.withError(e.response!.data);
    }
  }

  Future<CashResponse> openRegister(FormData data) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');

    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;

        options.headers["Cookie"] = aToken +
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
      String url = BASEURL! + AppConstants.BASE_URL + 'pos/open_register';
      print(url);
      response = await _dio.post(
        url,
        data: data,
      );
      print(response);
      return CashResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return CashResponse.withError(e.response!.data);
    }
  }
  Future<LogoResponse> getLogo() async {
    Response response;

    final prefs = await SharedPreferences.getInstance();


    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();


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
      String url = BASEURL! + AppConstants.BASE_URL + 'pos/logo';
      print(url);
      response = await _dio.get(
        url,
      );
      print(response);
      return LogoResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return LogoResponse.withError(e.response!.data,e.response!.statusCode!);
    }
  }

  Future<AddCustomerResponse> addCustomer(Map<String, dynamic> data) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');

    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = basicAuth;

        options.headers["Cookie"] = aToken +
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Customers/addCustomers';
      print(url);
      response = await _dio.post(url,
          //    data: data,
          queryParameters: data);
      print(response);
      return AddCustomerResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return AddCustomerResponse.withError(e.response!.data,e.response!.statusCode);
    }
  }
}
