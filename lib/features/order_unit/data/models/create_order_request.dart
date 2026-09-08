class CreateOrderRequest {
  final int? unitId;
  final int? solutionId;

  CreateOrderRequest({
    this.unitId,
    this.solutionId,
  }) : assert(
  (unitId != null) ^ (solutionId != null),
  'Either unitId or solutionId must be provided',
  );

  Map<String, dynamic> toMap() {
    return {
      if (unitId != null) "unit_id": unitId,
      if (solutionId != null) "solution_id": solutionId,
    };
  }
}