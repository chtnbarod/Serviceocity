import 'dart:convert';

class CheckoutData{
 final double price;
 final double tax;
 final double total;
 final double discount;
  CheckoutData({ required this.price,required this.tax,required this.total,required this.discount});
}

class PriceConverter {

  static double salePrice({ double? price,double? salePrice }){
    salePrice ??= 0;
    if(salePrice > 0){
      return removeDecimalZeroFormat(salePrice);
    }
    return removeDecimalZeroFormat(price??0);
  }

  static CheckoutData getCheckoutData({
    String? price,
    String? salePrice,
    String? quantity,
    String? tax,
    dynamic offerJson
  }){
    salePrice ??= "0";
    price ??= "0";
    tax ??= "0";
    quantity ??= "1";

    double salePrice2 = double.tryParse(salePrice)??0;
    double price2 = double.tryParse(price)??0;
    double tax2 = double.tryParse(tax)??0;
    double quantity2 = double.tryParse(quantity)??1;

    if(salePrice2 > 0){
      price2 = removeDecimalZeroFormat(salePrice2*quantity2);
    }else{
      price2 = removeDecimalZeroFormat(price2*quantity2);
    }

    if(tax2 > 0){
      tax2 += (price2 * tax2) / 100;
    }

    double discount = 0;
    if(offerJson['type'] != null){
      if(offerJson['type'] == 'amount'){
        double d = double.tryParse(offerJson['amount'].toString())??0;
        if(price2 > d){
          discount = d;
        }
      }
      if(offerJson['type'] == 'percent'){
         discount = (price2 * (double.tryParse(offerJson['percent'].toString())??0)) / 100;
      }
    }

   return CheckoutData(
      price: price2,
      tax: tax2,
      total: (price2 + tax2) - discount,
      discount: discount
    );
  }

  static String salePrice2({ String? price,String? salePrice }){
    double sale = double.tryParse(salePrice??"0")??0;
    if(sale > 0){
      return "${getFlag()}${removeDecimalZeroFormat(sale)}";
    }
    return "${getFlag()}${removeDecimalZeroFormat(double.tryParse(price??"0")??0)}";
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

}