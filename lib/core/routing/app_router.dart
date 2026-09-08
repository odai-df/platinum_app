import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/routing/routes.dart';
import 'package:platinum_app/features/ads/logic/advertisements_cubit.dart';
import 'package:platinum_app/features/appointment/ui/create_appointment_screen.dart';
import 'package:platinum_app/features/chat/logic/chat_cubit.dart';
import 'package:platinum_app/features/chat/ui/chat_screen.dart';
import 'package:platinum_app/features/home/logic/home_cubit.dart';
import 'package:platinum_app/features/home/ui/home_screen.dart';
import 'package:platinum_app/features/home/ui/main_screen.dart';
import 'package:platinum_app/features/login/logic/cubit/login_cubit.dart';
import 'package:platinum_app/features/login/ui/login_screen.dart';
import 'package:platinum_app/features/onboarding/onboarding_screen.dart';
import 'package:platinum_app/features/order_unit/logic/my_solution_cubit.dart';
import 'package:platinum_app/features/order_unit/logic/ordar_cubit.dart';
import 'package:platinum_app/features/order_unit/ui/my_order_screen.dart';
import 'package:platinum_app/features/profile/logic/profile_cubit.dart';
import 'package:platinum_app/features/profile/ui/edit_profile_screen.dart';
import 'package:platinum_app/features/profile/ui/profile_screen.dart';
import 'package:platinum_app/features/service/logic/solution_details_cubit.dart';
import 'package:platinum_app/features/service/logic/solutions_cubit.dart';
import 'package:platinum_app/features/service/ui/solution_details_screen.dart';
import 'package:platinum_app/features/units_details/logic/unit_details_cubit.dart';

import '../../features/ads/logic/advertisement_details_cubit.dart';
import '../../features/ads/ui/advertisement_details_screen.dart';
import '../../features/appointment/logic/create_appointment_cubit.dart';
import '../../features/appointment/ui/appointments_screen.dart';
import '../../features/chat/logic/faq_cubit.dart';
import '../../features/complaints/logic/complaint_types/complaint_types_cubit.dart';
import '../../features/complaints/logic/create_complaint/create_complaint_cubit.dart';
import '../../features/complaints/ui/create_complaint_screen.dart';
import '../../features/complaints/ui/my_complaints_screen.dart';
import '../../features/contracts/logic/contract_cubit.dart';
import '../../features/contracts/ui/contract_details_screen.dart';
import '../../features/contracts/ui/contract_screen.dart';
import '../../features/favorite/logic/favorite_cubit.dart';
import '../../features/favorite/ui/favorite_screen.dart';
import '../../features/home/ui/widgets/units_section.dart';
import '../../features/lottery/logic/lottery_cubit.dart';
import '../../features/lottery/ui/lottery_details_screen.dart';
import '../../features/lottery/ui/lottery_screen.dart';
import '../../features/my_units/ui/my_units_screen.dart';
import '../../features/my_units/ui/widgets/my_unit_details_screen.dart';
import '../../features/notifications/logic/notification_cubit.dart';
import '../../features/notifications/ui/notifications_screen.dart';
import '../../features/offers/ui/offers_screen.dart';
import '../../features/order_unit/logic/my_order_cubit.dart';
import '../../features/payment/logic/payment_cubit.dart';
import '../../features/payment/logic/upload_payment_file_cubit.dart';
import '../../features/payment/ui/payment_screen.dart';
import '../../features/profile/data/models/profile_data.dart';
import '../../features/search/logic/search_cubit.dart';
import '../../features/search/ui/search_screen.dart';
import '../../features/settings/ui/settings_screen.dart';
import '../../features/sign_up/logic/otp_cubit.dart';
import '../../features/sign_up/logic/sign_up_cubit.dart';
import '../../features/sign_up/ui/otp.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../../features/units/logic/units_cubit.dart';
import '../../features/units_details/ui/unit_details_screen.dart';
import '../../features/units/ui/units_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );

      case Routes.otp:
        final args = settings.arguments as Map<String, dynamic>?;
        final email = args?['email'];
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OtpCubit>(),
            child: OtpScreen(email: email),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [

              BlocProvider(create: (_) => getIt<AdvertisementsCubit>()),
              BlocProvider(create: (_) => getIt<SolutionsCubit>()),
              BlocProvider(create: (_) => getIt<SolutionDetailsCubit>()),
              BlocProvider(create: (_) => getIt<FavoriteCubit>()),
              BlocProvider(create: (_) => getIt<UnitsCubit>()),
              BlocProvider(create: (_) => getIt<ProfileCubit>()),
              BlocProvider(create: (_) => getIt<OrdersCubit>()),
              BlocProvider(create: (_) => getIt<SolutionOrdersCubit>()),
              BlocProvider(create: (_) => getIt<NotificationCubit>()),
            ],
            child: const MainScreen(),
          ),
        );

      case Routes.unitsScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<UnitsCubit>()),
              BlocProvider(create: (_) => getIt<FavoriteCubit>()),
            ],
            child: const UnitsSection(),
          ),
        );

      case Routes.unitDetailsScreen:
        final arguments = settings.arguments;

        late final int unitId;
        bool showOrderButton = true;

        if (arguments is int) {
          unitId = arguments;
        } else if (arguments is Map) {
          unitId = arguments['id'] as int;
          showOrderButton =
              arguments['showOrderButton'] as bool? ?? true;
        } else {
          throw ArgumentError(
            'Invalid arguments for unitDetailsScreen',
          );
        }

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<UnitsCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<FavoriteCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<UnitDetailCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<OrderCubit>(),
              ),
            ],
            child: UnitDetailsScreen(
              unitId: unitId,
              showOrderButton: showOrderButton,
            ),
          ),
        );


      case Routes.MyUnitDetailsScreen:
        final arguments = settings.arguments;

        late final int unitId;
        bool showOrderButton = true;

        if (arguments is int) {
          unitId = arguments;
        } else if (arguments is Map) {
          unitId = arguments['id'] as int;
          showOrderButton =
              arguments['showOrderButton'] as bool? ?? true;
        } else {
          throw ArgumentError(
            'Invalid arguments for unitDetailsScreen',
          );
        }

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<UnitsCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<FavoriteCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<UnitDetailCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<OrderCubit>(),
              ),
            ],
            child: MyUnitDetailsScreen(
              unitId: unitId,
              showOrderButton: showOrderButton,
            ),
          ),
        );

      case Routes.solutionDetails:
        final arguments = settings.arguments;

        late final int id;
        bool showOrderButton = true;

        if (arguments is int) {
          id = arguments;
        } else if (arguments is Map<String, dynamic>) {
          id = arguments['id'] as int;
          showOrderButton =
              arguments['showOrderButton'] as bool? ?? true;
        } else {
          throw ArgumentError(
            'Invalid arguments for solutionDetails',
          );
        }

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SolutionDetailsCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<OrderCubit>(),
              ),
            ],
            child: SolutionDetailsScreen(
              id: id,
              showOrderButton: showOrderButton,
            ),
          ),
        );

      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.editProfile:
        final profile = settings.arguments as ProfileData;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: EditProfileScreen(
              profile: profile,
            ),
          ),
        );

      case Routes.myFavorite:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FavoriteCubit>(),
            child: const FavoriteScreen(),
          ),
        );

      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case Routes.myOrder:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<OrdersCubit>()),
              BlocProvider(create: (_) => getIt<SolutionOrdersCubit>()),
            ],
            child: const MyOrdersScreen(),
          ),
        );

      case Routes.chat:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ChatCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<FaqCubit>(),
              ),
            ],
            child: const ChatScreen(),
          ),
        );

      case Routes.lottery:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<LotteryCubit>(),
              ),
            ],
            child: const LotteryScreen(),
          ),
        );

      case Routes.lotteryDetails:
        final id = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<LotteryCubit>()..getLotteryDetails(id),
            child: const LotteryDetailsScreen(),
          ),
        );

      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<SearchCubit>(),
              ),
            ],
            child: const SearchScreen(),
          ),
        );

      case Routes.contracts:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ContractCubit>()..getContracts(),
            child: const ContractScreen(),
          ),
        );

      case Routes.contractDetails:
        final id = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ContractCubit>()..getContractDetails(id),
            child: const ContractDetailsScreen(),
          ),
        );

      case Routes.notificationsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<NotificationCubit>()..getNotifications(),
            child: const NotificationsScreen(),
          ),
        );

      case Routes.advertisementDetails:
        final id = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AdvertisementDetailsCubit>(),
            child: AdvertisementDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.offersScreen:
        return MaterialPageRoute(
          builder: (_) => const OffersScreen(),
        );

      case Routes.paymentScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<PaymentCubit>()..getPayments(),
              ),
              BlocProvider(
                create: (_) => getIt<UploadPaymentFileCubit>(),
              ),
            ],
            child: const PaymentScreen(),
          ),
        );

      case Routes.appointmentsScreen:
        return MaterialPageRoute(
          builder: (_) => const AppointmentsScreen(),
        );

      case Routes.createAppointment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<CreateAppointmentCubit>(),
            child: const CreateAppointmentScreen(),
          ),
        );

      case Routes.myUnits:
        return MaterialPageRoute(
          builder: (_) => const MyUnitsScreen(),
        );

      case Routes.myComplaints:
        return MaterialPageRoute(
          builder: (_) => const MyComplaintsScreen(),
        );

      case Routes.createComplaint:
        final unitId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                getIt<ComplaintTypesCubit>()
                  ..getComplaintTypes(),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<CreateComplaintCubit>(),
              ),
            ],
            child: CreateComplaintScreen(
              unitId: unitId,
            ),
          ),
        );
      default:
        return null;
    }
  }
}
