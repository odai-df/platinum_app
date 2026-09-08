import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/complaint_repo.dart';
import 'complaint_types_state.dart';

class ComplaintTypesCubit extends Cubit<ComplaintTypesState> {
  final ComplaintRepo _repo;

  ComplaintTypesCubit(this._repo) : super(const ComplaintTypesState.initial());

  Future<void> getComplaintTypes() async {
    emit(const ComplaintTypesState.loading());

    final result = await _repo.getComplaintTypes();

    result.when(
      success: (types) {
        emit(
          ComplaintTypesState.success(types),
        );
      },
      failure: (error) {
        emit(
          ComplaintTypesState.error(
            error.apiErrorModel.message ?? 'Something went wrong',
          ),
        );
      },
    );
  }
}
