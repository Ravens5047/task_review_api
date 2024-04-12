class AppConstant {
  AppConstant._();

  static const baseTodo = 'http://206.189.150.98:3000/api/v1';
  static baseImage(String path) =>
      'http://206.189.150.98:3000/public/images/$path';

  static const endPointBaseImage = 'http://206.189.150.98:3000/public/images';
  static const endPointAuthRegister = '$baseTodo/auth/register';
  static const endPointOtp = '$baseTodo/auth/send-otp';
  static const endPointLogin = '$baseTodo/auth/login';
  static const endPointForgotPassword = '$baseTodo/auth/forgot-password';
  static const endPointChangePassword = '$baseTodo/auth/change-password';
  static const endPointGetProfile = '$baseTodo/user/get-me';
  static const endPointUpdateProfile = '$baseTodo/user/update/profile';
  static const endPointUploadFile = '$baseTodo/file/upload';
  static const endPointGetListTask = '$baseTodo/task/get-list';
  static const endPointTaskCreate = '$baseTodo/task/create';
  static const endPointTaskUpdate = '$baseTodo/task/update';
  static const endPointTaskDelete = '$baseTodo/task/delete';
  static const endPointTaskMultipleRestore = '$baseTodo/task/multiple-restore';
  static const endPointTaskMultipleDelete = '$baseTodo/task/multiple-delete';
}
