import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../config/language.dart';
import 'login_fresh_loading.dart';

class LoginFreshPhoneNumber extends StatefulWidget {
  LoginFreshPhoneNumber(
      {@required this.callLogin,
      this.backgroundColor,
      this.loginFreshWords,
      this.logo,
      this.isFooter,
      this.widgetFooter,
      this.isResetPassword,
      this.widgetResetPassword,
      this.isSignUp,
      this.signUp,
      this.textColor});

  final Color backgroundColor;
  final Function callLogin;
  final bool isFooter;
  final bool isResetPassword;
  final bool isSignUp;
  final LoginFreshWords loginFreshWords;
  final String logo;
  final Widget signUp;
  final Color textColor;
  final Widget widgetFooter;
  final Widget widgetResetPassword;

  @override
  _LoginFreshPhoneNumberState createState() => _LoginFreshPhoneNumberState();
}

class _LoginFreshPhoneNumberState extends State<LoginFreshPhoneNumber> {
  final focus = FocusNode();
  final bool isLoginRequest = false;
  bool isRequest = false;
  bool isVerifyCode = false;
  LoginFreshWords loginFreshWords;
  String _countryCode = '+233';

  StreamController<ErrorAnimationType> vCodeErrController =
      StreamController<ErrorAnimationType>();
  TextEditingController _textEditingControllerCode = TextEditingController();
  TextEditingController _textEditingControllerPhone = TextEditingController();

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 0,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (v) {
                              setState(() {
                                _countryCode = v.toString().trim();
                              });
                            },
                            alignLeft: false,
                            initialSelection: 'GH',
                            favorite: ['+233', 'NG'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                          )),
                      Expanded(
                        flex: 2,
                        child: TextField(
                            enabled: !isVerifyCode,
                            controller: this._textEditingControllerPhone,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: widget.textColor ?? Color(0xFF0F2E48),
                                fontSize: 14),
                            autofocus: false,
                            onSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus);
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                filled: true,
                                fillColor: Color(0xFFF3F3F5),
                                focusColor: Color(0xFFF3F3F5),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: widget.backgroundColor ??
                                            Color(0xFF4CAF50))),
                                hintText:
                                    this.loginFreshWords.hintPhoneNumber)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isVerifyCode,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: PinCodeTextField(
                      keyboardType: TextInputType.number,
                      focusNode: focus,
                      appContext: context,
                      autoFocus: true,
                      autoDisposeControllers: false,
                      autoDismissKeyboard: true,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.green,
                        inactiveColor: Colors.white,
                        inactiveFillColor: Colors.green,
                        selectedFillColor: Colors.blue.shade50,
                        selectedColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.green.shade50,
                      enableActiveFill: true,
                      errorAnimationController: vCodeErrController,
                      controller: this._textEditingControllerCode,
                      onCompleted: (value) {
                        widget.callLogin(
                          context,
                          setIsRequest,
                          setIsVerifyCode,
                          errorWrongCode,
                          normalizePhoneNumber(
                              this._textEditingControllerPhone.text,
                              _countryCode),
                          this._textEditingControllerCode.text,
                          isVerifyCode,
                        );
                      },
                      onChanged: (value) {
                        // print("========================+++> " + value);
                      },
                      beforeTextPaste: (value) {
                        // print(
                        //     "======================> Allowing to paste $value");
                        return true;
                      },
                    ),
                  ),
                ),
                (this.isRequest)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoadingLoginFresh(
                          textLoading: this.loginFreshWords.textLoading,
                          colorText: widget.textColor,
                          backgroundColor: widget.backgroundColor,
                          elevation: 0,
                        ),
                      )
                    : Visibility(
                        visible: !isVerifyCode,
                        child: GestureDetector(
                          onTap: () {
                            widget.callLogin(
                              context,
                              setIsRequest,
                              setIsVerifyCode,
                              errorWrongCode,
                              normalizePhoneNumber(
                                  this._textEditingControllerPhone.text,
                                  _countryCode),
                              this._textEditingControllerCode.text,
                              isVerifyCode,
                            );
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color:
                                  widget.backgroundColor ?? Color(0xFF4CAF50),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(
                                    !isVerifyCode
                                        ? this.loginFreshWords.next
                                        : this.loginFreshWords.verify,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: this.loginFreshWords.notAccount + ' \n',
                            style: TextStyle(
                                color: widget.textColor ?? Color(0xFF0F2E48),
                                fontWeight: FontWeight.normal,
                                fontSize: 15)),
                        TextSpan(
                            text: this.loginFreshWords.signUp,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: widget.textColor ?? Color(0xFF0F2E48),
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ]),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_buildContext) => widget.signUp),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: (widget.isFooter == null || widget.isFooter == false)
              ? SizedBox()
              : widget.widgetFooter,
        ),
      ],
    );
  }

  void setIsRequest(bool isRequest) {
    setState(() {
      this.isRequest = isRequest;
    });
  }

  void setIsVerifyCode(bool isVerifyCode) {
    setState(() {
      this.isVerifyCode = isVerifyCode;
    });
  }

  void errorWrongCode() {
    vCodeErrController?.add(ErrorAnimationType.shake);
  }

  String normalizePhoneNumber(String number, String countryCode) {
    if (number.isEmpty) {
      return "";
    }
    number = number.replaceAll(
        "[^+0-9]", ""); // All weird characters such as /, -, ...
    if (number.substring(0, 1).compareTo("0") == 0 &&
        number.substring(1, 2).compareTo("0") != 0) {
      number = countryCode +
          number.substring(
              1); // e.g. 0172 12 34 567 -> + (country_code) 172 12 34 567
    } else if (number.length < 10) {
      number = countryCode + number;
    }
    number =
        number.replaceAll("^[0]{1,4}", "+"); // e.g. 004912345678 -> +4912345678
    return number;
  }

  @override
  Widget build(BuildContext context) {
    loginFreshWords = (widget.loginFreshWords == null)
        ? LoginFreshWords()
        : widget.loginFreshWords;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (vCodeErrController != null) vCodeErrController.close();
      vCodeErrController = StreamController<ErrorAnimationType>();
    });

    return WillPopScope(
      onWillPop: () async {
        if (isVerifyCode) {
          setIsVerifyCode(false);
          _textEditingControllerCode?.clear();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: widget.backgroundColor ?? Color(0xFF4CAF50),
          centerTitle: true,
          elevation: 0,
          title: Text(
            this.loginFreshWords.login,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                color: widget.backgroundColor ?? Color(0xFF4CAF50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 3),
                          child: Hero(
                            tag: 'hero-login',
                            child: Image.asset(
                              widget.logo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    color: Color(0xFFF3F3F5),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      topRight: const Radius.circular(50.0),
                    )),
                child: buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
