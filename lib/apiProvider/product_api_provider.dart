import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/add_product_list_response.dart';
import 'package:icon/response/product_response.dart';
import 'package:icon/response/sub_cat_response.dart';

import 'package:icon/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductApiProvider {
  Dio _dio = Dio();

  ProductApiProvider() {
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

  Future<GetListAddProductResponse> getDropListAddPro(FormData data) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/add';
      response = await _dio.post(
        url,data: data
      );
      print(response);


      return GetListAddProductResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return GetListAddProductResponse.withError(e.response!.data,e.response!.statusCode!);
    }
  }
  Future<SubCategoryResponse> GettSubCat(String catId ) async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/SubCategories?parent_id='+catId;
      response = await _dio.get(
          url
      );
      print(response);


      return SubCategoryResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return SubCategoryResponse.withError(e.response!.data,e.response!.statusCode!);
    }
  }
  Future<ProductResponse> getProduct() async {
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
          'products?include=brand,category';

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
  Future<SubCategoryResponse> GettSubCatAll() async {
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/SubCategoriesAll';
      response = await _dio.get(
          url
      );
      print(response);


      return SubCategoryResponse.fromJson(response.data, response.statusCode!);
    } on DioError catch (e) {
      print("Exception occured: $e stackTrace");
      return SubCategoryResponse.withError(e.response!.data,e.response!.statusCode!);
    }
  }

  Future<AddCustomerResponse> addProduct(FormData data) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');
    String? aToken = prefs.getString('aToken');
    String lastT=  aToken! +'; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
        token!;
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = 'Basic b3duZXI6MTIzNDU2Nzg=';
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/add';
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
  Future<AddCustomerResponse> editProduct(FormData data,String proId) async {
    Response response;

    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('user');
    String? password = prefs.getString('pass');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    String? token = prefs.getString('token');
    String? aToken = prefs.getString('aToken');
    String lastT=  aToken! +'; sma_cart_id=1f2578c19fc2fac95ab25b28be129223; sma_token_cookie=' +
        token!;
    try {
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        _dio.interceptors.requestLock.lock();
        options.headers["authorization"] = 'Basic b3duZXI6MTIzNDU2Nzg=';
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
      String url = BASEURL! + AppConstants.BASE_URL + 'products/edit_Products/'+proId;
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

  Future<AddCustomerResponse> deletePro(String proId) async {
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
        options.headers["authorization"] = 'Basic b3duZXI6MTIzNDU2Nzg=';
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
      String url = BASEURL! + AppConstants.BASE_URL + 'Products/delete_Products/'+proId;
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

}
