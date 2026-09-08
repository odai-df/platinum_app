class SearchRequest {
  final int? locationId;
  final String? type;
  final int? priceMin;
  final int? priceMax;
  final int? floor;
  final int? roomsCount;
  final int? areaMin;
  final int? areaMax;

  const SearchRequest({
    this.locationId,
    this.type,
    this.priceMin,
    this.priceMax,
    this.floor,
    this.roomsCount,
    this.areaMin,
    this.areaMax,
  });

  Map<String, dynamic> toJson() {
    return {
      "location_id": locationId,
      "type": type,
      "price_min": priceMin,
      "price_max": priceMax,
      "floor": floor,
      "rooms_count": roomsCount,
      "area_min": areaMin,
      "area_max": areaMax,
    }..removeWhere(
          (key, value) => value == null || value.toString().isEmpty,
    );
  }
}