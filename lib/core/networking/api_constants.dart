class ApiConstants {
  static const String apiBaseUrl = "https://platinum-back-end.onrender.com/api/v1";

  static const String login = "/login";
  static const String signup = "/client";
  static const String verifyOtp = '/verifyEmail';
  static const String resendCode = '/resendCode';
  static const String units = '/client/unit/read/';
  static const String addFavorite ='/favorite/';
  static const String myFavorite ='/favorite/my';
  static const String deleteFavorite ='/favorite/';
  static const String profile = "/client/profile";
  static const String unitsDetails = '/client/unit/';
  static const String getActiveAdvertisements = '/client/advertisement/active';
  static const String solution = '/client/solution/read';
  static const String editProfile = '/client';
  static const String createOrder = '/order';
  static const String myOrderUnit = '/order/myUnitOrders';
  static const String myOrderSolution = '/order/mySolutionOrders';
  static const String createRoom = "/chat/rooms";
  static const String sendMessage = "/chat/message";
  static const String roomMessages = "/chat/rooms";
  static const String broadcastingAuth = "/broadcasting/auth";
  static const String lottery = "/client/lottery";
  static const String offers = "/client/offer";
  static const String payments = "/client/payment";


}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
