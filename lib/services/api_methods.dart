class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String login = 'login';
  String OtpVerify = 'verify_otp';
  String updateProfile = 'update_user';
  String registerUser = 'user_register';
   String mobileOtpVerify = 'MobileVerify/mobileOtpVerify';
  String updateToken = 'updatetoken/usercurrenttoken';
  String resetPassword = 'reset_password';
  String sendOtp = 'send_otp';



}