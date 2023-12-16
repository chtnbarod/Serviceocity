import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/WalletModel.dart';

import '../../core/di/api_client.dart';
import '../../model/TransactionModel.dart';

class WalletLogic extends GetxController {
  final ApiClient apiClient;
  WalletLogic({required this.apiClient});

  @override
  void onInit() {
    super.onInit();
    getWallet();
  }

  WalletModel? wallet;
  List<TransactionModel> model = [];
  bool inProcess = false;
  getWallet() async{
    model.clear();
    inProcess = true;
    await apiClient.getAPI(ApiProvider.viewWallet).then((value) => {
      if(value.statusCode == 200){
        wallet = WalletModel.fromJson(value.body['wallet_data']),
        value.body['transactions'].forEach((v) {
          model.add(TransactionModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      inProcess = false,
      update(),
    });
  }


}
