import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../logic/available_slots_cubit.dart';
import '../logic/available_slots_state.dart';
import '../logic/create_appointment_cubit.dart';
import '../logic/create_appointment_state.dart';

class AppointmentTypes {
  static const String legalConsultation = 'legal_consultation';
  static const String sales = 'sales';
  static const String general = 'general';
}

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState
    extends State<CreateAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          getIt<AvailableSlotsCubit>()..getAvailableSlots(),
        ),
        BlocProvider(
          create: (_) =>
              getIt<CreateAppointmentCubit>(),
        ),
      ],
      child: const _CreateAppointmentView(),
    );
  }
}
class _CreateAppointmentView extends StatefulWidget {
  const _CreateAppointmentView();

  @override
  State<_CreateAppointmentView> createState() => _CreateAppointmentViewState();
}

class _CreateAppointmentViewState extends State<_CreateAppointmentView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _notesController =
  TextEditingController();

  String? selectedType;
  int? selectedSlotId;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateAppointmentCubit, CreateAppointmentState>(
          listener: (context, state) {
            if (state is CreateAppointmentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: Text(
                    'Appointment booked successfully'.tr(),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              Navigator.pop(context, true);
            }

            if (state is CreateAppointmentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: context.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.bgColor,
          foregroundColor: context.textColor,
          centerTitle: true,
          scrolledUnderElevation: 0,
          title:  Text(
            'Book Appointment'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                18,
                10,
                18,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 28),

                  _sectionTitle(
                    context,
                    'Appointment Type'.tr(),
                    'Choose the service you need'.tr(),
                  ),

                  const SizedBox(height: 14),
                  _buildAppointmentTypes(context),

                  const SizedBox(height: 30),

                  _sectionTitle(
                    context,
                    'Available Time'.tr(),
                    'Select a suitable date and time'.tr(),
                  ),

                  const SizedBox(height: 14),
                  _buildAvailableSlots(context),

                  const SizedBox(height: 30),

                  _sectionTitle(
                    context,
                    'Notes'.tr(),
                    'Add any details you want us to know'.tr(),
                  ),

                  const SizedBox(height: 14),
                  _buildNotesField(context),

                  const SizedBox(height: 30),
                  _buildBookButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Schedule a meeting'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Choose your preferred time and service.'.tr(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(.82),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION TITLE
  // ---------------------------------------------------------------------------

  Widget _sectionTitle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: context.subTextColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // APPOINTMENT TYPES
  // ---------------------------------------------------------------------------

  Widget _buildAppointmentTypes(BuildContext context) {
    final types = [
      _AppointmentTypeItem(
        value: AppointmentTypes.legalConsultation,
        title: 'Legal Consultation'.tr(),
        subtitle: 'Legal advice & consultation'.tr(),
        icon: Icons.gavel_rounded,
      ),
      _AppointmentTypeItem(
        value: AppointmentTypes.sales,
        title: 'Sales'.tr(),
        subtitle: 'Property & sales assistance'.tr(),
        icon: Icons.sell_outlined,
      ),
      _AppointmentTypeItem(
        value: AppointmentTypes.general,
        title: 'General'.tr(),
        subtitle: 'General inquiries'.tr(),
        icon: Icons.support_agent_rounded,
      ),
    ];

    return Column(
      children: types.map((item) {
        final selected = selectedType == item.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedType = item.value;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withOpacity(.08)
                    : context.cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : context.isDark
                          ? Colors.white.withOpacity(.08)
                          : Colors.grey.shade200,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary.withOpacity(.12)
                          : context.isDark
                              ? Colors.white.withOpacity(.06)
                              : Colors.grey.withOpacity(.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      item.icon,
                      color:
                          selected ? AppColors.primary : context.subTextColor,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            color: context.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            color: context.subTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    width: 23,
                    height: 23,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : context.subTextColor.withOpacity(.35),
                        width: 1.5,
                      ),
                    ),
                    child: selected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // AVAILABLE SLOTS
  // ---------------------------------------------------------------------------

  Widget _buildAvailableSlots(BuildContext context) {
    return BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
      builder: (context, state) {
        if (state is AvailableSlotsLoading) {
          return _buildSlotsLoading(context);
        }

        if (state is AvailableSlotsError) {
          return _buildErrorBox(
            context,
            state.message,
          );
        }

        if (state is AvailableSlotsSuccess) {
          final slots = state.slots;

          if (slots.isEmpty) {
            return _buildEmptySlots(context);
          }

          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: slots.map((slot) {
              final selected = selectedSlotId == slot.id;

              final time = _formatTime(slot.startTime);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSlotId = slot.id;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 112,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : context.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : context.isDark
                              ? Colors.white.withOpacity(.08)
                              : Colors.grey.shade200,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(.18),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 20,
                        color: selected ? Colors.white : AppColors.primary,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        time,
                        style: TextStyle(
                          color: selected ? Colors.white : context.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _formatDate(slot.date),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected
                              ? Colors.white.withOpacity(.82)
                              : context.subTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }

        return const SizedBox();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // NOTES
  // ---------------------------------------------------------------------------

  Widget _buildNotesField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.isDark
              ? Colors.white.withOpacity(.08)
              : Colors.grey.shade200,
        ),
      ),
      child: TextFormField(
        controller: _notesController,
        maxLines: 5,
        minLines: 4,
        style: TextStyle(
          color: context.textColor,
          fontSize: 14,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Notes are required".tr();
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: 'Write your notes here...'.tr(),
          hintStyle: TextStyle(
            color: context.subTextColor.withOpacity(.7),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 10,
              top: 14,
            ),
            child: Icon(
              Icons.notes_rounded,
              color: AppColors.primary,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BOOK BUTTON
  // ---------------------------------------------------------------------------

  Widget _buildBookButton(BuildContext context) {
    return BlocBuilder<CreateAppointmentCubit, CreateAppointmentState>(
      builder: (context, state) {
        final loading = state is CreateAppointmentLoading;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: loading ? null : _submitAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: loading
                ? const SizedBox(
                    width: 23,
                    height: 23,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                :  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 21,
                      ),
                      SizedBox(width: 9),
                      Text(
                        'Book Appointment'.tr(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // SUBMIT
  // ---------------------------------------------------------------------------

  void _submitAppointment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedType == null) {
      _showMessage(
        'Please select an appointment type'.tr(),
      );
      return;
    }

    if (selectedSlotId == null) {
      _showMessage(
        'Please select an available time'.tr(),
      );
      return;
    }

    final notes = _notesController.text.trim();

    context.read<CreateAppointmentCubit>().createAppointment(
      slotId: selectedSlotId!,
      type: selectedType!,
      notes: notes,
    );
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------

  String _formatTime(String value) {
    try {
      final parts = value.split(':');

      if (parts.length < 2) {
        return value;
      }

      int hour = int.parse(parts[0]);
      final minute = parts[1];

      final period = hour >= 12 ? 'PM' : 'AM';

      hour = hour % 12;

      if (hour == 0) {
        hour = 12;
      }

      return '$hour:$minute $period';
    } catch (_) {
      return value;
    }
  }

  String _formatDate(String value) {
    try {
      final parts = value.split('-');

      if (parts.length != 3) {
        return value;
      }

      return '${parts[2]}/${parts[1]}/${parts[0]}';
    } catch (_) {
      return value;
    }
  }

  Widget _buildSlotsLoading(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        4,
        (_) => Container(
          width: 112,
          height: 100,
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySlots(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: 42,
            color: context.subTextColor,
          ),
          const SizedBox(height: 10),
          Text(
            'No available times'.tr(),
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'There are no available appointment slots at the moment.'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBox(
    BuildContext context,
    String message,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.red.withOpacity(.15),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<AvailableSlotsCubit>().getAvailableSlots();
            },
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _AppointmentTypeItem {
  final String value;
  final String title;
  final String subtitle;
  final IconData icon;

  const _AppointmentTypeItem({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
