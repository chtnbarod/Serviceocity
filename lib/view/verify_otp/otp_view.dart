import 'package:flutter/material.dart';

class OtpView extends StatefulWidget {
  final Color? backgroundColor;
  final Function(List<int> list)? otpCallBack;
  const OtpView({Key? key,this.backgroundColor,this.otpCallBack}) : super(key: key);

  @override
  State<OtpView> createState() => OtpViewState();
}

class OtpViewState extends State<OtpView> {

  setOTP(List<String> otp){
    if(otp.length != 6) return;
    otp1Controller.text = otp[0];
    otp2Controller.text = otp[1];
    otp3Controller.text = otp[2];
    otp4Controller.text = otp[3];
    otp5Controller.text = otp[4];
    otp6Controller.text = otp[5];
    focusNode1.unfocus();
    focusNode2.unfocus();
    focusNode3.unfocus();
    focusNode4.unfocus();
    focusNode5.unfocus();
    focusNode6.unfocus();
    otpString = [
      (int.tryParse(otp[0].toString())??-1),
      (int.tryParse(otp[1].toString())??-1),
      (int.tryParse(otp[2].toString())??-1),
      (int.tryParse(otp[3].toString())??-1),
      (int.tryParse(otp[4].toString())??-1),
      (int.tryParse(otp[5].toString())??-1),
    ];
    if(widget.otpCallBack != null){
      widget.otpCallBack!(otpString);
    }
    setState(() {});
  }

  void refreshData() {
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
    otp6Controller.clear();
    focusNode1.unfocus();
    focusNode2.unfocus();
    focusNode3.unfocus();
    focusNode4.unfocus();
    focusNode5.unfocus();
    focusNode6.unfocus();
    setState(() {});
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();
  final TextEditingController otp5Controller = TextEditingController();
  final TextEditingController otp6Controller = TextEditingController();


  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();

  List<int> otpString = [ -1 , -1 , -1 , -1 , -1 , -1];

  bool removeOrAdd(int i , String s){
    int index = i - 1;
    if(s.isNotEmpty){
      otpString[index] = int.parse(s);
      if(widget.otpCallBack != null){
        widget.otpCallBack!(otpString);
      }
      return true;
    }else{
      otpString[index] = -1;
      if(widget.otpCallBack != null){
        widget.otpCallBack!(otpString);
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildScreen();
  }

  Widget _buildScreen(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Enter OTP Here"),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                      color: (widget.backgroundColor ?? Colors.grey), width: 0.7)),
                ),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: TextField(
                    maxLines: 1,
                    maxLength: 1,
                    controller: otp1Controller,
                    focusNode: focusNode1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (String? s) {
                      if (s?.isEmpty ?? false) {
                        focusNode1.unfocus();
                      }
                    },
                    onChanged: (otp) {
                      if (removeOrAdd(1, otp)) {
                        FocusScope.of(context).requestFocus(
                            focusNode2);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counter: const Offstage(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: (widget.backgroundColor ?? Colors.grey) .withOpacity(
                              0.5)
                      ),
                      errorStyle: const TextStyle(height: 1.5),
                    ),
                  ),
                ),
              ),

              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                      color: (widget.backgroundColor ?? Colors.grey), width: 0.7)),
                ),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: TextField(
                    maxLines: 1,
                    maxLength: 1,
                    focusNode: focusNode2,
                    controller: otp2Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (String? s) {
                      if (s?.isEmpty ?? false) {
                        focusNode2.unfocus();
                      }
                    },
                    onChanged: (otp) {
                      if (removeOrAdd(2, otp)) {
                        FocusScope.of(context).requestFocus(
                            focusNode3);
                      }
                      else {
                        FocusScope.of(context).requestFocus(
                            focusNode1);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counter: const Offstage(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: (widget.backgroundColor ?? Colors.grey).withOpacity(
                              0.5)
                      ),
                      errorStyle: const TextStyle(height: 1.5),
                    ),
                  ),
                ),
              ),

              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                      color: (widget.backgroundColor ?? Colors.grey), width: 0.7)),
                ),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: TextField(
                    maxLines: 1,
                    maxLength: 1,
                    controller: otp3Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    focusNode: focusNode3,
                    onSubmitted: (String? s) {
                      if (s?.isEmpty ?? false) {
                        focusNode3.unfocus();
                      }
                    },
                    onChanged: (otp) {
                      if (removeOrAdd(3, otp)) {
                        FocusScope.of(context).requestFocus(
                            focusNode4);
                      }
                      else {
                        FocusScope.of(context).requestFocus(
                            focusNode2);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counter: const Offstage(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: (widget.backgroundColor ?? Colors.grey).withOpacity(
                              0.5)
                      ),
                      errorStyle: const TextStyle(height: 1.5),
                    ),
                  ),
                ),
              ),

              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                      color: (widget.backgroundColor ?? Colors.grey), width: 0.7)),
                ),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: TextField(
                    maxLines: 1,
                    maxLength: 1,
                    controller: otp4Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    focusNode: focusNode4,
                    onSubmitted: (String? s) {
                      if (s?.isEmpty ?? false) {
                        focusNode4.unfocus();
                      }
                    },
                    onChanged: (otp) {
                      if (removeOrAdd(4, otp)) {
                        FocusScope.of(context).requestFocus(
                            focusNode5);
                      }
                      else {
                        FocusScope.of(context).requestFocus(
                            focusNode3);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counter: const Offstage(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: (widget.backgroundColor ?? Colors.grey).withOpacity(
                              0.5)
                      ),
                      errorStyle: const TextStyle(height: 1.5),
                    ),
                  ),
                ),
              ),

              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                      color: (widget.backgroundColor ?? Colors.grey), width: 0.7)),
                ),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: TextField(
                    maxLines: 1,
                    maxLength: 1,
                    controller: otp5Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    focusNode: focusNode5,
                    onSubmitted: (String? s) {
                      if (s?.isEmpty ?? false) {
                        focusNode5.unfocus();
                      }
                    },
                    onChanged: (otp) {
                      if (removeOrAdd(5, otp)) {
                        FocusScope.of(context).requestFocus(
                            focusNode6);
                      }
                      else {
                        FocusScope.of(context).requestFocus(
                            focusNode4);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counter: const Offstage(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: (widget.backgroundColor ?? Colors.grey).withOpacity(
                              0.5)
                      ),
                      errorStyle: const TextStyle(height: 1.5),
                    ),
                  ),
                ),
              ),
              //
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                      color: (widget.backgroundColor ?? Colors.grey), width: 0.7)),
                ),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: TextField(
                    maxLines: 1,
                    maxLength: 1,
                    focusNode: focusNode6,
                    controller: otp6Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    onChanged: (otp) {
                      if (removeOrAdd(6, otp)) {
                        focusNode6.unfocus();
                      }
                      else {
                        FocusScope.of(context).requestFocus(
                            focusNode5);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counter: const Offstage(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: (widget.backgroundColor ?? Colors.grey).withOpacity(
                              0.5)
                      ),
                      errorStyle: const TextStyle(height: 1.5),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
