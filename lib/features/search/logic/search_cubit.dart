import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/location_model.dart';
import '../data/models/search_request.dart';
import '../data/models/search_response.dart';
import '../data/repos/search_repo.dart';
import '../logic/search_state.dart';
import '../../units/data/models/unit_model.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(SearchInitial());

  /// Locations
  List<LocationModel> locations = [];

  /// Search Result
  List<UnitModel> units = [];

  /// Current Filters
  int? selectedLocationId;

  String? selectedType;

  int? priceMin;

  int? priceMax;

  int? floor;

  int? roomsCount;

  int? areaMin;

  int? areaMax;

  ///==============================
  /// Load Locations
  ///==============================

  Future<void> loadLocations() async {
    emit(SearchLoading());

    final result = await searchRepo.getLocations();

    result.when(
      success: (response) {
        locations = (response.data ?? [])
            .where((e) => e.type == "district")
            .toList();

        emit(SearchLoaded());
      },
      failure: (error) {
        emit(
          SearchError(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  ///==============================
  /// Search
  ///==============================

  Future<void> search() async {
    emit(SearchSearching());

    final request = SearchRequest(
      locationId: selectedLocationId,
      type: selectedType,
      priceMin: priceMin,
      priceMax: priceMax,
      floor: floor,
      roomsCount: roomsCount,
      areaMin: areaMin,
      areaMax: areaMax,
    );

    final result =
    await searchRepo.searchUnits(request);

    result.when(
      success: (SearchResponse response) {
        units = response.data ?? [];

        if (units.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchResultsLoaded());
        }
      },
      failure: (error) {
        emit(
          SearchError(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  ///==============================
  /// Setters
  ///==============================

  void setLocation(int? id) {
    selectedLocationId = id;
    emit(SearchLoaded());
  }

  void setType(String? type) {
    selectedType = type;
    emit(SearchLoaded());
  }

  void setPriceMin(String value) {
    priceMin = int.tryParse(value);
  }

  void setPriceMax(String value) {
    priceMax = int.tryParse(value);
  }

  void setAreaMin(String value) {
    areaMin = int.tryParse(value);
  }

  void setAreaMax(String value) {
    areaMax = int.tryParse(value);
  }

  void setFloor(String value) {
    floor = int.tryParse(value);
  }

  void setRooms(String value) {
    roomsCount = int.tryParse(value);
  }

  ///==============================
  /// Clear Filters
  ///==============================

  void clearFilters() {
    selectedLocationId = null;
    selectedType = null;
    priceMin = null;
    priceMax = null;
    floor = null;
    roomsCount = null;
    areaMin = null;
    areaMax = null;

    units.clear();

    emit(SearchLoaded());
  }
}