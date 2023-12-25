import 'dart:convert';
import 'dart:math';

import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:crypto/crypto.dart';
import 'package:serviceocity/utils/price_converter.dart';

class PayNow{
  final double amount;
  PayNow({ required this.amount });

  bool enableLogs = true;
  String environmentValue = 'UAT_SIM';
  String appId = "";
  String packageName = "com.serviceocity.serviceocity";
  String merchantId = "PGTESTPAYUAT";
  String checksum = "";
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";
  String callback = "https://webhook.site/a4dd1720-b6fa-423a-b556-c27f5d4ed6d0";

  String body = "";
  String txtId = "";

  // String? result;

  String apiEndPoint = "/pg/v1/pay";

  Map<String, String> pgHeaders = {"Content-Type": "application/json"};


  void init(){
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs);
  }

  String generateUniqueId() {
    // Get current DateTime in microseconds
    int microseconds = DateTime.now().microsecondsSinceEpoch;

    // Generate a random 6-digit number
    int random = Random().nextInt(999999);

    // Combine DateTime and random number, format it to 18 digits
    String uniqueId = '$microseconds$random'.substring(0, 18);

    return uniqueId;
  }

 void generateChecksum() {

   txtId = generateUniqueId();

    dynamic body = {
      "merchantId": merchantId,
      "merchantTransactionId": txtId,
      "merchantUserId": "MUID123",
      "amount": PriceConverter.getSingleDigit2(amount * 100),
      "mobileNumber": "9999999999",
      "callbackUrl": callback,
      "paymentInstrument": {
        "type": "PAY_PAGE",// PAY_PAGE | UPI_INTENT
      }
    };

    String base64Body =  base64.encode(utf8.encode(json.encode(body)));

    checksum = '${sha256.convert(utf8.encode(base64Body+apiEndPoint+saltKey)).toString()}###$saltIndex';

    this.body = base64Body;

  }


 Future<bool> pay() async{
    bool isSuccess = false;
    try {
      await PhonePePaymentSdk.startPGTransaction(body, callback, checksum, pgHeaders, apiEndPoint, packageName).then((value) => {
        if(value?['status'] == "SUCCESS"){
         isSuccess = true,
        }
      });
      /// {status: SUCCESS};
    } catch (error) {
      print("errorPay $error");
    }
    return isSuccess;
  }

}