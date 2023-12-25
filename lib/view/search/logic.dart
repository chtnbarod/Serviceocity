import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';

import '../../core/di/api_client.dart';
import '../../model/SearchServiceModel.dart';

class SearchLogic extends GetxController {
  final ApiClient apiClient;
  SearchLogic({required this.apiClient});

  final TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    focusNode.requestFocus();
  }

  pickVoice(String? text){
    if(text?.isNotEmpty??false){
      controller.text = text!;
      focusNode.unfocus();
      update();
      search(text);
    }
  }
  
  List<SearchServiceModel> model = [];
  bool isSearching = false;
  void search(String? str) async{
    if(isSearching) return;
    model.clear();
    isSearching = true;
    update();
    await apiClient.postAPI(ApiProvider.searchService, {
      "name" : str
    }).then((value) => {
      model.clear(),
      if(value.statusCode == 200){
        value.body['services'].forEach((v) {
          model.add(SearchServiceModel.fromJson(v));
        }),
      }
    });
    isSearching = false;
    update();
  }

}
