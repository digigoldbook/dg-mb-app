part of 'estimation_step_cubit.dart';

sealed class EstimationStepState extends Equatable {
  const EstimationStepState();

  @override
  List<Object> get props => [];
}

final class EstimationStepInitial extends EstimationStepState {
  final int newStep;

  const EstimationStepInitial({
    required this.newStep,
  });

  @override
  List<Object> get props => [newStep];
}
