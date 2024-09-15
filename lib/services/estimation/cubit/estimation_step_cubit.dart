import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'estimation_step_state.dart';

class EstimationStepCubit extends Cubit<EstimationStepState> {
  EstimationStepCubit() : super(const EstimationStepInitial(newStep: 0));

  void updateStep(int newStep) {
    emit(EstimationStepInitial(newStep: newStep));
  }
}
