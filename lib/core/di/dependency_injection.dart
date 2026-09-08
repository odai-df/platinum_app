import 'package:dio/dio.dart';
import 'package:platinum_app/core/networking/api_service.dart';
import 'package:platinum_app/core/networking/dio_factory.dart';
import 'package:platinum_app/features/ads/data/repos/advertisements_repo.dart';
import 'package:platinum_app/features/ads/logic/advertisements_cubit.dart';
import 'package:platinum_app/features/home/data/apis/home_api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:platinum_app/features/notifications/logic/notification_cubit.dart';
import 'package:platinum_app/features/order_unit/data/repos/order_repo.dart';
import 'package:platinum_app/features/order_unit/logic/my_order_cubit.dart';
import 'package:platinum_app/features/order_unit/logic/ordar_cubit.dart';
import 'package:platinum_app/features/profile/data/repos/profile_repo.dart';
import 'package:platinum_app/features/profile/logic/profile_cubit.dart';
import 'package:platinum_app/features/service/data/repos/solution_repo.dart';
import 'package:platinum_app/features/service/logic/solution_details_cubit.dart';
import 'package:platinum_app/features/service/logic/solutions_cubit.dart';
import 'package:platinum_app/features/units_details/data/repos/unit_details_repos.dart';
import 'package:platinum_app/features/units_details/logic/unit_details_cubit.dart';

import '../../features/ads/logic/advertisement_details_cubit.dart';
import '../../features/appointment/data/repos/appointment_repo.dart';
import '../../features/appointment/logic/appointment_cubit.dart';
import '../../features/appointment/logic/available_slots_cubit.dart';
import '../../features/appointment/logic/cancel_appointment_cubit.dart';
import '../../features/appointment/logic/create_appointment_cubit.dart';
import '../../features/chat/data/repo/chat_repo.dart';
import '../../features/chat/data/repo/faqRepo.dart';
import '../../features/chat/data/services/chat_pusher_service.dart';
import '../../features/chat/logic/chat_cubit.dart';
import '../../features/chat/logic/faq_cubit.dart';
import '../../features/complaints/data/repos/complaint_repo.dart';
import '../../features/complaints/logic/complaint_types/complaint_types_cubit.dart';
import '../../features/complaints/logic/create_complaint/create_complaint_cubit.dart';
import '../../features/complaints/logic/my_complaints_cubit.dart';
import '../../features/contracts/data/repo/contract_repo.dart';
import '../../features/contracts/logic/contract_cubit.dart';
import '../../features/favorite/data/repos/favorite_repo.dart';
import '../../features/favorite/logic/favorite_cubit.dart';
import '../../features/home/data/repos/home_repo.dart';
import '../../features/login/data/repos/login_repo.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/lottery/data/repo/lottery_repo.dart';
import '../../features/lottery/logic/lottery_cubit.dart';
import '../../features/my_units/data/repo/my_units_repo.dart';
import '../../features/my_units/logic/my_units_cubit.dart';
import '../../features/notifications/data/repo/notification_repo.dart';
import '../../features/offers/data/repo/offers_repo.dart';
import '../../features/offers/logic/offers_cubit.dart';
import '../../features/order_unit/logic/my_solution_cubit.dart';
import '../../features/payment/data/repos/payment_repo.dart';
import '../../features/payment/logic/payment_cubit.dart';
import '../../features/payment/logic/upload_payment_file_cubit.dart';
import '../../features/search/data/repos/search_repo.dart';
import '../../features/search/logic/search_cubit.dart';
import '../../features/sign_up/data/repos/otp_repo.dart';
import '../../features/sign_up/data/repos/sign_up_repo.dart';
import '../../features/sign_up/logic/otp_cubit.dart';
import '../../features/sign_up/logic/sign_up_cubit.dart';
import '../../features/units/data/repos/units_repo.dart';
import '../../features/units/logic/units_cubit.dart';
import '../notifications/firebase_notification_service.dart';
import '../notifications/notification_repo.dart';
import '../theming/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<NotificationRepo>(
        () => NotificationRepo(
      getIt<ApiService>(),
    ),
  );

  getIt.registerLazySingleton<FirebaseNotificationService>(
        () => FirebaseNotificationService(
      getIt<NotificationRepo>(),
    ),
  );

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt<Dio>()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt<SignupRepo>()));

  getIt.registerLazySingleton<OtpRepo>(() => OtpRepo(getIt()));
  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt<OtpRepo>()));

  // home
  // getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  // getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  //

  getIt.registerLazySingleton<FaqRepo>(
        () => FaqRepo(
      getIt<ApiService>(),
    ),
  );

  getIt.registerFactory<FaqCubit>(
        () => FaqCubit(
      getIt<FaqRepo>(),
    ),
  );

//units
  getIt.registerLazySingleton<UnitsRepo>(
        () => UnitsRepo(getIt()),
  );

  getIt.registerFactory<UnitsCubit>(
        () => UnitsCubit(getIt<UnitsRepo>()),
  );
// details
  getIt.registerLazySingleton<UnitDetailRepoImpl>(
        () => UnitDetailRepoImpl(getIt()),
  );

  getIt.registerFactory<UnitDetailCubit>(
        () => UnitDetailCubit(getIt<UnitDetailRepoImpl>()),
  );


  //favorite
  getIt.registerLazySingleton<FavoriteRepo>(
        () => FavoriteRepo(getIt()),
  );

  getIt.registerFactory<FavoriteCubit>(
        () => FavoriteCubit(getIt()),
  );



  // ads
  getIt.registerLazySingleton<AdvertisementsRepo>(
        () => AdvertisementsRepo(getIt()),
  );

  getIt.registerFactory<AdvertisementsCubit>(
        () => AdvertisementsCubit(getIt()),
  );
  // solution
  getIt.registerLazySingleton<SolutionsRepo>(
        () => SolutionsRepo(getIt()),
  );

  getIt.registerFactory<SolutionsCubit>(
        () => SolutionsCubit(getIt()),
  );

  // solution Details


  getIt.registerFactory<SolutionDetailsCubit>(
        () => SolutionDetailsCubit(getIt()),
  );



  // profile
  getIt.registerLazySingleton<ProfileRepo>(
        () => ProfileRepo(getIt()),
  );

  getIt.registerFactory<ProfileCubit>(
        () => ProfileCubit(getIt()),
  );

// order
  getIt.registerLazySingleton<OrderRepo>(
        () => OrderRepo(getIt()),
  );

  getIt.registerFactory<OrderCubit>(
        () => OrderCubit(getIt()),
  );

  // orders

  getIt.registerFactory<OrdersCubit>(
        () => OrdersCubit(getIt()),
  );
  getIt.registerFactory<SolutionOrdersCubit>(
        () => SolutionOrdersCubit(getIt()),
  );


  getIt.registerLazySingleton<ChatRepo>(
        () => ChatRepo(getIt()),
  );
  getIt.registerFactory<ChatCubit>(
        () => ChatCubit(
      getIt<ChatRepo>(),
      getIt<ChatPusherService>(),
    ),
  );

  getIt.registerLazySingleton<ChatPusherService>(
        () => ChatPusherService(),
  );



  getIt.registerFactory<NotificationCubit>(
        () => NotificationCubit(getIt<NotificationsRepo>()),
  );
  getIt.registerLazySingleton<NotificationsRepo>(
        () => NotificationsRepo(
      getIt<ApiService>(),
    ),
  );




  getIt.registerLazySingleton<LotteryRepo>(
        () => LotteryRepo(getIt<ApiService>()),
  );

  getIt.registerFactory<LotteryCubit>(
        () => LotteryCubit(getIt<LotteryRepo>()),
  );




  getIt.registerLazySingleton<SearchRepo>(
        () => SearchRepo(
      getIt<ApiService>(),
    ),
  );
  getIt.registerFactory<SearchCubit>(
        () => SearchCubit(
      getIt<SearchRepo>(),
    ),
  );


  getIt.registerLazySingleton<ContractRepo>(
        () => ContractRepo(
      getIt<ApiService>(),
    ),
  );


  getIt.registerFactory<ContractCubit>(
        () => ContractCubit(
      getIt<ContractRepo>(),
    ),
  );


  getIt.registerFactory<AdvertisementDetailsCubit>(
        () => AdvertisementDetailsCubit(
      getIt<AdvertisementsRepo>(),
    ),
  );



  getIt.registerLazySingleton<OffersRepo>(
        () => OffersRepo(getIt<ApiService>()),
  );

  getIt.registerFactory<OffersCubit>(
        () => OffersCubit(getIt<OffersRepo>()),
  );

  getIt.registerLazySingleton<PaymentRepo>(
        () => PaymentRepo(getIt<ApiService>()),
  );

  getIt.registerFactory<PaymentCubit>(
        () => PaymentCubit(getIt<PaymentRepo>()),
  );


  getIt.registerLazySingleton<AppointmentRepo>(
        () => AppointmentRepo(getIt<ApiService>()),
  );

  getIt.registerFactory<AppointmentCubit>(
        () => AppointmentCubit(getIt<AppointmentRepo>()),
  );
  getIt.registerFactory<AvailableSlotsCubit>(
        () => AvailableSlotsCubit(
      getIt<AppointmentRepo>(),
    ),
  );

  getIt.registerFactory<CreateAppointmentCubit>(
        () => CreateAppointmentCubit(
      getIt<AppointmentRepo>(),
    ),
  );


  getIt.registerFactory<CancelAppointmentCubit>(
        () => CancelAppointmentCubit(
      getIt<AppointmentRepo>(),
    ),
  );



  getIt.registerLazySingleton<MyUnitsRepo>(
        () => MyUnitsRepo(getIt<ApiService>()),
  );

  getIt.registerFactory<MyUnitsCubit>(
        () => MyUnitsCubit(getIt<MyUnitsRepo>()),
  );



  getIt.registerFactory<UploadPaymentFileCubit>(
        () => UploadPaymentFileCubit(
      getIt<PaymentRepo>(),
    ),
  );

  getIt.registerLazySingleton<ComplaintRepo>(
        () => ComplaintRepo(
      getIt<ApiService>(),
    ),
  );

  getIt.registerFactory<MyComplaintsCubit>(
        () => MyComplaintsCubit(
      getIt<ComplaintRepo>(),
    ),
  );


  getIt.registerFactory<ComplaintTypesCubit>(
        () => ComplaintTypesCubit(
      getIt<ComplaintRepo>(),
    ),
  );

  getIt.registerFactory<CreateComplaintCubit>(
        () => CreateComplaintCubit(
      getIt<ComplaintRepo>(),
    ),
  );
}
