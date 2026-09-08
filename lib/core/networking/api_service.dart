import 'dart:io';

import 'package:dio/dio.dart';
import 'package:platinum_app/core/networking/api_constants.dart';
import 'package:platinum_app/features/favorite/data/models/favorite_model.dart';
import 'package:platinum_app/features/favorite/data/models/favorite_response.dart';
import 'package:platinum_app/features/login/data/models/login_request_body.dart';
import 'package:platinum_app/features/login/data/models/login_response.dart';
import 'package:platinum_app/features/profile/data/models/edit_profile_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/ads/data/models/advertisement_details_response.dart';
import '../../features/ads/data/models/advertisements_response.dart';
import '../../features/appointment/data/models/appointment_response.dart';
import '../../features/appointment/data/models/available_slots_response.dart';
import '../../features/appointment/data/models/cancel_appointment_response.dart';
import '../../features/appointment/data/models/create_appointment_response.dart';
import '../../features/chat/data/models/chat_messages_response.dart';
import '../../features/chat/data/models/chat_room_response.dart';
import '../../features/chat/data/models/faq_response.dart';
import '../../features/complaints/data/models/complaint_types_response.dart';
import '../../features/complaints/data/models/create_complaint_response.dart';
import '../../features/complaints/data/models/my_complaints_response.dart';
import '../../features/contracts/data/models/contract_details_response.dart';
import '../../features/contracts/data/models/contract_response.dart';
import '../../features/lottery/data/models/lottery_details_response.dart';
import '../../features/lottery/data/models/lottery_response.dart';
import '../../features/my_units/data/models/my_units_response.dart';
import '../../features/notifications/data/models/notifications_response.dart';
import '../../features/notifications/data/models/unread_count_response.dart';
import '../../features/offers/data/models/offers_response.dart';
import '../../features/order_unit/data/models/my_order_response.dart';
import '../../features/order_unit/data/models/my_solution_orders_response.dart';
import '../../features/order_unit/data/models/order_response.dart';
import '../../features/payment/data/models/payment_response_model.dart';
import '../../features/payment/data/models/payment_upload_response.dart';
import '../../features/profile/data/models/profile_model.dart';
import '../../features/service/data/models/solution_details_response.dart';
import '../../features/service/data/models/solutions_response.dart';
import '../../features/sign_up/data/models/otp_request_body.dart';
import '../../features/sign_up/data/models/otp_response.dart';
import '../../features/sign_up/data/models/sign_up_request_body.dart';
import '../../features/sign_up/data/models/sign_up_response.dart';
import '../../features/units/data/models/unit_response.dart';
import '../../features/units_details/data/models/unit_detail_response.dart';
import '../../features/search/data/models/location_response.dart';
import '../../features/search/data/models/search_response.dart';
import 'api_response.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody,);

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signupRequestBody,);

  @POST(ApiConstants.verifyOtp)
  Future<OtpResponse> verifyOtp(@Body() OtpRequestBody otpRequestBody,);

  @POST(ApiConstants.resendCode)
  Future<dynamic> sendCode(@Body() Map<String, dynamic> body);


  @GET(ApiConstants.units)
  Future<UnitsResponse> getUnits(@Query("page") int page,);

  // @GET("${ApiConstants.units}/{id}")
  // Future<UnitDetailsResponse> getUnitDetails(
  //     @Path("id") int id,
  //     );


  /////
  @POST("${ApiConstants.addFavorite}/{id}")
  Future<dynamic> toggleFavorite(@Path("id") int unitId);

  @DELETE("${ApiConstants.deleteFavorite}/{id}")
  Future<dynamic> deleteFavorite(@Path("id") int unitId);

  @GET(ApiConstants.myFavorite)
  Future<FavoriteResponse> getMyFavorites();

////////


  @GET(ApiConstants.profile)
  Future<ProfileModel> getProfile();

  @GET("${ApiConstants.unitsDetails}{id}")
  Future<UnitDetailResponse> getUnitDetails(@Path('id') int id,);


  @GET(ApiConstants.getActiveAdvertisements)
  Future<AdvertisementsResponse> getActiveAdvertisements();

  @GET('${ApiConstants.apiBaseUrl}/client/advertisement/read/{id}')
  Future<AdvertisementDetailsResponse> getAdvertisementDetails(
      @Path('id') int id,
      );

  @GET(ApiConstants.solution)
  Future<SolutionsResponse> getSolutions();

  @GET("${ApiConstants.solution}/{id}")
  Future<SolutionDetailsResponse> getSolutionDetails(@Path("id") int id,);

  @PUT(ApiConstants.editProfile)
  Future<EditProfileResponse> editProfile(@Body() Map<String, dynamic> data,);


  @POST(ApiConstants.createOrder)
  Future<OrderResponse> createOrder(@Body() Map<String, dynamic> data,);


  @GET(ApiConstants.myOrderUnit)
  Future<MyOrdersResponse> getMyOrders();


  @GET(ApiConstants.myOrderSolution)
  Future<MySolutionOrdersResponse> getMySolutionOrders();

  @POST(ApiConstants.createRoom)
  Future<ChatRoomResponse> createChatRoom();
  @GET('${ApiConstants.apiBaseUrl}/chat/rooms/{id}/messages')
  Future<ChatMessagesResponse> getRoomMessages(
      @Path('id') int roomId,
      );

  @POST(ApiConstants.sendMessage)
  Future<dynamic> sendMessage(
      @Body() Map<String, dynamic> body,
      );


  @GET(ApiConstants.lottery)
  Future<LotteryResponse> getLotteries();

  @GET("${ApiConstants.apiBaseUrl}/client/lottery/{id}")
  Future<LotteryDetailsResponse> getLotteryDetails(
      @Path("id") int id,
      );

  @POST("${ApiConstants.apiBaseUrl}/client/unit/search")
  Future<SearchResponse> searchUnits(
      @Body() Map<String, dynamic> body,
      );

  @GET("${ApiConstants.apiBaseUrl}/location")
  Future<LocationResponse> getLocations();


  @GET("${ApiConstants.apiBaseUrl}/client/contract")
  Future<ContractResponse> getContracts();



  @GET("${ApiConstants.apiBaseUrl}/client/contract/{id}")
  Future<ContractDetailsResponse> getContractDetails(
      @Path("id") int id,
      );


  @POST("${ApiConstants.apiBaseUrl}/device-tokens")
  Future<ApiResponse> registerDeviceToken(
      @Body() Map<String, dynamic> body,
      );

  @DELETE("${ApiConstants.apiBaseUrl}/device-tokens")
  Future<ApiResponse> deleteDeviceToken(
      @Body() Map<String, dynamic> body,
      );


  @GET("${ApiConstants.apiBaseUrl}/notifications")
  Future<NotificationsResponse> getNotifications(

      );

  @GET("${ApiConstants.apiBaseUrl}/notifications/unread-count")
  Future<UnreadCountResponse> getUnreadCount();


  @PATCH('${ApiConstants.apiBaseUrl}/notifications/{id}/read')
  Future<ApiResponse> markNotificationAsRead(
      @Path('id') String id,
      );

  @PATCH("${ApiConstants.apiBaseUrl}/notifications/read-all")
  Future<ApiResponse> markAllNotificationsAsRead();



  @GET(ApiConstants.offers)
  Future<OffersResponse> getOffers();

  @GET(ApiConstants.payments)
  Future<PaymentResponse> getPayments();


  @GET("${ApiConstants.apiBaseUrl}/appointment/client/myAppointments")
  Future<AppointmentResponse> getMyAppointments();

  @GET("${ApiConstants.apiBaseUrl}/client/slots/available")
  Future<AvailableSlotsResponse> getAvailableSlots();


  @POST("${ApiConstants.apiBaseUrl}/appointment")
  Future<CreateAppointmentResponse> createAppointment(
      @Body() Map<String, dynamic> body,
      );


  @PUT("${ApiConstants.apiBaseUrl}/appointment/cancel/{id}")
  Future<CancelAppointmentResponse> cancelAppointment(
      @Path("id") int appointmentId,
      );


  @GET('${ApiConstants.apiBaseUrl}/faqs/root')
  Future<FaqResponse> getFaqRoot();

  @GET('${ApiConstants.apiBaseUrl}/faqs/{id}/children')
  Future<FaqResponse> getFaqChildren(
      @Path('id') int id,
      );


  @GET("${ApiConstants.apiBaseUrl}/client/myUnits")
  Future<MyUnitsResponse> getMyUnits();


  @PUT("${ApiConstants.apiBaseUrl}/payment/uploadFile/{id}")
  Future<PaymentUploadResponse> uploadPaymentFiles(
      @Path("id") int paymentId,
      @Body() FormData formData,
      );


  @GET("${ApiConstants.apiBaseUrl}/complaint/client/myComplaints")
  Future<MyComplaintsResponse> getMyComplaints();

  @GET("${ApiConstants.apiBaseUrl}/complaint/type/read")
  Future<ComplaintTypesResponse> getComplaintTypes();


  @POST("${ApiConstants.apiBaseUrl}/complaint/")
  Future<CreateComplaintResponse> createComplaint(
      @Body() FormData formData,
      );




}
