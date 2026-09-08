import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/complaint_repo.dart';
import 'my_complaints_state.dart';

class MyComplaintsCubit extends Cubit<MyComplaintsState> {
  final ComplaintRepo _repo;

  MyComplaintsCubit(this._repo) : super(const MyComplaintsState.initial());

  Future<void> getMyComplaints() async {
    emit(const MyComplaintsState.loading());

    final result = await _repo.getMyComplaints();

    result.when(
      success: (complaints) {
        emit(
          MyComplaintsState.success(complaints),
        );
      },
      failure: (error) {
        emit(
          MyComplaintsState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }
}
