class LoginFreshWords {
  String loginWith;
  String login;
  String exploreApp;
  String notAccount;
  String signUp;
  String textLoading;
  String hintLoginUser;
  String hintLoginPassword;
  String hintSignUpRepeatPassword;
  String hintName;
  String hintSurname;
  String hintPhoneNumber;
  String hintPhoneCode;
  String next;
  String verify;
  String resendCode;

  String recoverPassword;

  String messageRecoverPassword;

  LoginFreshWords(
      {this.loginWith = 'Login With',
      this.hintName = 'Name',
      this.hintSurname = 'Surname',
      this.hintSignUpRepeatPassword = 'Repeat Password',
      this.hintLoginPassword = 'Password',
      this.recoverPassword = 'Recover Password',
      this.messageRecoverPassword =
          'To recover the password, enter the email and press send email, you will receive an email so you can update your password. Only available for accounts created by username and password',
      this.hintLoginUser = 'Email',
      this.login = 'Login',
      this.exploreApp = 'Explore App',
      this.notAccount = 'You do not have an account?',
      this.signUp = 'Sign Up',
      this.hintPhoneNumber = 'Enter phone',
      this.hintPhoneCode = 'Enter verification code',
      this.next = "Next",
      this.verify = "Verify",
      this.resendCode = "Resend Code",
      this.textLoading = 'please wait ...'});
}
