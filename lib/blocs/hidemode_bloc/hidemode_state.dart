part of "hidemode_bloc.dart";

class HideModeState extends Equatable {
  const HideModeState();

  @override
  List<Object?> get props => [];
}

class HideModeInitState extends HideModeState{}

class ChangeHideModeLoadingState extends HideModeState {}

class ChangeHideModeSuccessState extends HideModeState{
  final HideModeModel hideModeModel;
  const ChangeHideModeSuccessState({required this.hideModeModel});

  @override
  List<Object?> get props => [hideModeModel];
}

class ChangeHideModeErrorState extends HideModeState{
  final String errorMessage;
  const ChangeHideModeErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}