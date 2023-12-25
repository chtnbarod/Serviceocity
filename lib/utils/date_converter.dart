import 'dart:math';

import 'package:intl/intl.dart';

extension StringExtensions on String {


  String toImageName() {
    if (isEmpty) {
      return this;
    }

    List<String> nameParts = split(' ');
    if (nameParts.isNotEmpty) {
      String initials = '';
      for (String part in nameParts) {
        initials += part.isNotEmpty ? part[0] : '';
      }
      return initials.toUpperCase();
    }

    return this;
  }

  String toCapitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    final trimmedString = trim();
    final firstNonSpaceIndex = trimmedString.indexOf(RegExp(r'\S'));
    if (firstNonSpaceIndex == -1) {
      // The string contains only spaces
      return this;
    }
    return substring(0, firstNonSpaceIndex) +
        trimmedString[firstNonSpaceIndex].toUpperCase() +
        trimmedString.substring(firstNonSpaceIndex + 1);
  }

  String toDateDMMM(){
    try{
      return (DateFormat('d MMM').format(DateTime.parse(this))).toUpperCase();
    }catch (e){
      return this;
    }
  }

  String toDateDMMMY(){
    try{
      return DateFormat('d MMM, y').format(DateTime.parse(this));
    }catch (e){
      return this;
    }
  }

  String toDateDMMMYY(){
    try{
      return (DateFormat('d MMM, yy').format(DateTime.parse(this))).toUpperCase();
    }catch (e){
      return this;
    }
  }

  String toDateMMMMYYYY(){
    try{
      return DateFormat('MMMM, yyyy').format(DateTime.parse(this));
    }catch (e){
      return this;
    }
  }

  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }


  String toMinToHM(){
    try{
      var duration = Duration(minutes: int.tryParse(this)??0);
      List<String> parts = duration.toString().split(':');
      return '${parts[0].padLeft(2, '')}H : ${parts[1].padLeft(2, '0')}M';
    }catch (e){
      return "?";
    }
  }

  String toSecToMS(){
    try{
      var duration = Duration(seconds: int.tryParse(this)??0);
      String mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
      String ss = (duration.inSeconds % 60).toString().padLeft(2, '0');
      return '$mm : $ss';
    }catch (e){
      return "?";
    }
  }
}
