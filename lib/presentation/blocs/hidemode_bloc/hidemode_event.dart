part of "hidemode_bloc.dart";

class HideModeEvent extends Equatable{
  const HideModeEvent();

  @override
  List<Object?> get props => [];

}

class ChangeHideModeEvent extends HideModeEvent{
  final HideModeModel hideModeModel;
  const ChangeHideModeEvent({required this.hideModeModel});

  @override
  List<Object?> get props => [hideModeModel];
}