import 'dart:convert';

import '../model/CartModel.dart';



class PriceConverter {

  static double salePrice({ double? price,double? salePrice }){
    salePrice ??= 0;
    if(salePrice > 0){
      return removeDecimalZeroFormat(salePrice);
    }
    return removeDecimalZeroFormat(price??0);
  }

  static String salePrice2({ String? price,String? salePrice, String? quantity }){
    double sale = double.tryParse(salePrice??"0")??0;
    double quantity2 = double.tryParse(quantity??"0")??0;
    if(quantity2 <= 0){
      quantity2 = 1;
    }
    if(sale > 0){
      return "${getFlag()}${removeDecimalZeroFormat(sale*quantity2)}";
    }
    return "${getFlag()}${removeDecimalZeroFormat(double.tryParse(price??"0")??0)*quantity2}";
  }

  static String salePrice3({ double? price = 0,double? salePrice }){
    salePrice ??= 0;
    if(salePrice > 0){
      return "${getFlag()}${removeDecimalZeroFormat(salePrice??0)}";
    }
    return "${getFlag()}${removeDecimalZeroFormat(price??0)}";
  }


  static double removeDecimalZeroFormat(double value , { int asFixed = 2 }) {
    return double.tryParse(value.toStringAsFixed(asFixed))??0.0;
  }

  static String removeDecimalZeroFormat2(double value , { int asFixed = 2 }) {
    return value.toStringAsFixed(asFixed);
  }

  static String getSingleDigit(double? value) {
    return (value??0.0).toStringAsFixed(0);
  }


  static String removeDecimalZeroFormatWithFlag(double value , { int asFixed = 2 }) {
    return "${getFlag()}${value.toStringAsFixed(asFixed)}";
  }

  static String getFlag() {
    return  "₹";
  }

  static String getMultiplication () {
    return  "x";
  }
}