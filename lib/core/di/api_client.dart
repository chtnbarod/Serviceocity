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

  final bool useDio = true;
  ApiClient({required this.sharedPreferences,required this.apkBaseUrl}){
    initHttp();
    _mainHeaders = { "Authorization" : 'Bearer $token',"Accept" : "application/json" };
  }

  initHttp(){
    httpClient.baseUrl = apkBaseUrl;
    token = sharedPreferences.getString(ApiProvider.preferencesToken);
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

  Future<Response> getAPI(String url) async {
    try {
      return await _handleHttpResponse(await get(url, headers: _mainHeaders),url: url);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteAPI(String url) async {
    try {
      return await _handleHttpResponse(await delete(url, headers: _mainHeaders),url: url);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postAPI(String? url, dynamic body) async {
    try {
      return _handleHttpResponse(await post(url, body,headers: _mainHeaders),body: body,url: url);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putAPI(String url, dynamic body) async {
    try {
      return _handleHttpResponse(await put(url,body,headers: _mainHeaders,),body: body,url: url);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _handleHttpResponse(Response response,{ dynamic body, String? url }) async {
    print("\n<>--------------\n$url\n$body-----------------------<>\n");
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
    }else if(response.statusCode == 422){
      Toast.show(toastMessage: response.body?['error']??response.body?['message']??"Opp! Internal Issue");
    }
    return response;
  }
}