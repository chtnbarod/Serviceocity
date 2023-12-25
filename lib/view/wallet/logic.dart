import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/WalletModel.dart';

import '../../core/di/api_client.dart';
import '../../model/TransactionModel.dart';

class WalletLogic extends GetxController implements GetxService {
  final ApiClient apiClient;
  WalletLogic({required this.apiClient});

  @override
  void onInit() {
    super.onInit();
    getWallet();
  }

  WalletModel? wallet;
  List<TransactionModel> model = [];
  double totalDebit = 0;
  double totalCredit = 0;
  bool inProcess = false;
  getWallet() async{
    model.clear();
    totalDebit = 0;
    totalCredit = 0;
    inProcess = true;
    await apiClient.getAPI(ApiProvider.viewWallet).then((value) => {
      if(value.statusCode == 200){
        wallet = WalletModel.fromJson(value.body['wallet_data']),
        value.body['transactions'].forEach((v) {
          if("${v['type']}".toUpperCase() == "CREDIT"){
            totalCredit+= double.tryParse(v['amount'].toString())??0;
          }else if("${v['type']}".toUpperCase() == "DEBIT"){
            totalDebit+= double.tryParse(v['amount'].toString())??0;
          }
          model.add(TransactionModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      inProcess = false,
      update(),
    });
  }
}
