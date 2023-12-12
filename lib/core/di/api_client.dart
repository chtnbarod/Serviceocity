import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/toast.dart';
import '../../view/account/logic.dart';
import 'api_provider.dart';

class ApiClient extends GetConnect implements GetxService{
  String? token;
  final String apkBaseUrl;
  Map<String,String>? _mainHeaders;
  final SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences,required this.apkBaseUrl}){
    updateServer(apkBaseUrl);
    httpClient.timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(ApiProvider.preferencesToken);
    _mainHeaders = { "Authorization" : 'Bearer $token',"Accept" : "application/json" };
  }

  updateServer(String baseUrl){
    httpClient.baseUrl = baseUrl;
  }

  updateHeader(String token){
    this.token = token;
    _mainHeaders = {
      "Accept" : "application/json",
      "Authorization" : 'Bearer $token',
    };
  }

  static const String noInternetMessage = 'Please Check Your Connection';
  static const String invalidUser = 'Session expired';
  static const int errorCode = -101;
  static const int noInternetCode = -1;

  Future<Response> getAPI(String url, {bool useHeader = true}) async {
    try {
      print("_mainHeaders $_mainHeaders");
      return await _handleResponse(await get(url, headers: useHeader ? _mainHeaders : null),"\n<>_______________url::<$url>_______________headers::<${useHeader ? _mainHeaders : null}>_______________query::<$query>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteAPI(String url, {bool useHeader = true}) async {
    try {
      print("_mainHeaders $_mainHeaders");
      return await _handleResponse(await delete(url, headers: useHeader ? _mainHeaders : null),"\n<>_______________url::<$url>_______________headers::<${useHeader ? _mainHeaders : null}>_______________query::<$query>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postAPI(String? url, dynamic body, {Map<String, dynamic>? query,bool useHeader = true}) async {
    try {
      return _handleResponse(await post(url, body,headers: useHeader ? _mainHeaders : null),"\n<>_______________url::<$url>_______________headers::<${useHeader ? _mainHeaders : null}>_______________body::<$body>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putAPI(String url, dynamic body, {Map<String, dynamic>? query,bool useHeader = true}) async {
    try {
      return _handleResponse(await put(url,body,headers: useHeader ? _mainHeaders : null,),"\n<>_______________url::<$url>_______________headers::<${useHeader ? _mainHeaders : null}>_______________body::<$body>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _handleResponse(Response response,String test) async {
    print("$test\n");
    print("\n<>******************${response.statusCode}*${response.body}*******************<>\n");
    // chk now all status is 404 422 200 401
    if (response.status.hasError) {
      if (response.statusCode == 401) {
        Toast.show(toastMessage: "Session expired",isError: true);
        Get.find<AccountLogic>().logout();
        throw Exception(invalidUser);
      }
      if (response.status.connectionError) {
        throw Exception(noInternetMessage);
      }
    }
    return response;
  }
}