import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/complaint_repo.dart';
import 'create_complaint_state.dart';

class CreateComplaintCubit extends Cubit<CreateComplaintState> {
  final ComplaintRepo _repo;

  CreateComplaintCubit(this._repo)
      : super(const CreateComplaintState.initial());

  Future<void> createComplaint({
    required int complaintTypeId,
    required String title,
    required String body,
    required int unitId,
    required List<File> attachments,
  }) async {
    emit(
      const CreateComplaintState.loading(),
    );

    final result = await _repo.createComplaint(
      complaintTypeId: complaintTypeId,
      title: title,
      body: body,
      unitId: unitId,
      attachments: attachments,
    );

    result.when(
      success: (response) {
        emit(
          CreateComplaintState.success(
            response.message ?? 'Stored successfully.',
          ),
        );
      },
      failure: (error) {
        emit(
          CreateComplaintState.error(
            error.apiErrorModel.message ?? 'Something went wrong',
          ),
        );
      },
    );
  }
}
