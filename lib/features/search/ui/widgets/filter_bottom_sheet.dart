import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';
import '../../logic/search_cubit.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController priceMinController = TextEditingController();

  final TextEditingController priceMaxController = TextEditingController();

  final TextEditingController areaMinController = TextEditingController();

  final TextEditingController areaMaxController = TextEditingController();

  final TextEditingController floorController = TextEditingController();

  final TextEditingController roomsController = TextEditingController();

  @override
  void dispose() {
    priceMinController.dispose();
    priceMaxController.dispose();
    areaMinController.dispose();
    areaMaxController.dispose();
    floorController.dispose();
    roomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return DraggableScrollableSheet(
      initialChildSize: .85,
      maxChildSize: .95,
      minChildSize: .55,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: context.bgColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(22),
            children: [
              /// HANDLE
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? Colors.white.withOpacity(.18)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// TITLE
              Text(
                "Filters".tr(),
                style: TextStyle(
                  color: context.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 25),

              /// LOCATION
              DropdownButtonFormField<int>(
                value: cubit.selectedLocationId,
                dropdownColor: context.cardColor,
                style: TextStyle(
                  color: context.textColor,
                  fontSize: 14,
                ),
                decoration: _inputDecoration(
                  context,
                  label: "Location".tr(),
                  icon: Icons.location_on_outlined,
                ),
                items: cubit.locations
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.displayName,
                          style: TextStyle(
                            color: context.textColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: cubit.setLocation,
              ),

              const SizedBox(height: 20),

              /// TYPE
              DropdownButtonFormField<String>(
                value: cubit.selectedType,
                dropdownColor: context.cardColor,
                style: TextStyle(
                  color: context.textColor,
                  fontSize: 14,
                ),
                decoration: _inputDecoration(
                  context,
                  label: "Unit Type".tr(),
                  icon: Icons.apartment_outlined,
                ),
                items: [
                  DropdownMenuItem(
                    value: "vip",
                    child: Text(
                      "VIP".tr(),
                      style: TextStyle(
                        color: context.textColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "social",
                    child: Text(
                      "Social".tr(),
                      style: TextStyle(
                        color: context.textColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "investment",
                    child: Text(
                      "Investment".tr(),
                      style: TextStyle(
                        color: context.textColor,
                      ),
                    ),
                  ),
                ],
                onChanged: cubit.setType,
              ),

              const SizedBox(height: 25),

              /// PRICE
              _sectionTitle(
                context,
                "Price".tr(),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: priceMinController,
                      label: "Min".tr(),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: priceMaxController,
                      label: "Max".tr(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// AREA
              _sectionTitle(
                context,
                "Area".tr(),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: areaMinController,
                      label: "Min m²".tr(),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: areaMaxController,
                      label: "Max m²".tr(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// FLOOR + ROOMS
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: floorController,
                      label: "Floor".tr(),
                      icon: Icons.layers_outlined,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: roomsController,
                      label: "Rooms".tr(),
                      icon: Icons.meeting_room_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              /// SEARCH
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                  label: Text(
                    "Search Units".tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    cubit.setPriceMin(
                      priceMinController.text,
                    );

                    cubit.setPriceMax(
                      priceMaxController.text,
                    );

                    cubit.setAreaMin(
                      areaMinController.text,
                    );

                    cubit.setAreaMax(
                      areaMaxController.text,
                    );

                    cubit.setFloor(
                      floorController.text,
                    );

                    cubit.setRooms(
                      roomsController.text,
                    );

                    Navigator.pop(context);

                    await cubit.search();
                  },
                ),
              ),

              const SizedBox(height: 12),

              /// CLEAR
              SizedBox(
                height: 52,
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.refresh_rounded,
                  ),
                  label: Text(
                    "Clear Filters".tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.textColor,
                    side: BorderSide(
                      color: context.isDark
                          ? Colors.white.withOpacity(.10)
                          : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    cubit.clearFilters();

                    priceMinController.clear();
                    priceMaxController.clear();
                    areaMinController.clear();
                    areaMaxController.clear();
                    floorController.clear();
                    roomsController.clear();

                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(
    BuildContext context,
    String title,
  ) {
    return Text(
      title,
      style: TextStyle(
        color: context.textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: context.textColor,
      ),
      cursorColor: AppColors.primary,
      decoration: _inputDecoration(
        context,
        label: label,
        icon: icon,
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: context.subTextColor,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColors.primary,
      ),
      prefixIcon: icon == null
          ? null
          : Icon(
              icon,
              color: context.subTextColor,
            ),
      filled: true,
      fillColor: context.cardColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: context.isDark
              ? Colors.white.withOpacity(.08)
              : Colors.grey.shade200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: context.isDark
              ? Colors.white.withOpacity(.08)
              : Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    );
  }
}
