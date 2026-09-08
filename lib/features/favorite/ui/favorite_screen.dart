import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../../home/ui/widgets/unit_card.dart';
import '../logic/favorite_cubit.dart';
import '../logic/favorite_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    super.initState();

    context.read<FavoriteCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.bgColor,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: context.bgColor,

        title: Text(
          "My Favorites".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textColor,
          ),
        ),
      ),

      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {

          return state.maybeWhen(

            /// ================= LOADING =================
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },

            /// ================= LOADED =================
            loaded: (favorites) {

              if (favorites.isEmpty) {
                return _emptyState();
              }

              return RefreshIndicator(

                color: AppColors.primary,

                onRefresh: () async {
                  await context
                      .read<FavoriteCubit>()
                      .getFavorites();
                },

                child: ListView.builder(
                  physics:
                  const AlwaysScrollableScrollPhysics(),

                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                  ),

                  itemCount: favorites.length,

                  itemBuilder: (context, index) {

                    final favorite = favorites[index];
                    final unit = favorite.unit;

                    return UnitCard(
                      unit: unit,
                      showFavorite: true,
                    );
                  },
                ),
              );
            },

            /// ================= ERROR =================
            error: (msg) {
              return _errorState("");
            },

            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  /// ================= EMPTY STATE =================

  Widget _emptyState() {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.favorite_border,
            size: 70,
            color: context.subTextColor,
          ),

          const SizedBox(height: 14),

          Text(
            "No favorites yet".tr(),
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Start adding your favorite apartments".tr(),
            style: TextStyle(
              color: context.subTextColor.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= ERROR STATE =================

  Widget _errorState(String msg) {

    return Center(
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 55,
            ),

            const SizedBox(height: 12),

            Text(
              "Something went wrong".tr(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                onPressed: () {
                  context
                      .read<FavoriteCubit>()
                      .getFavorites();
                },

                child:  Text(
                  "Try Again".tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= SNACK BAR =================

  void _showSnack(
      BuildContext context,
      String msg, {
        bool isError = false,
      }) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,

        backgroundColor:
        isError
            ? Colors.red
            : AppColors.primary,

        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}