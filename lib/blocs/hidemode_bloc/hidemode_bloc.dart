import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_tracking/models/models.dart';

import '../../repositories/repositories.dart';

part "hidemode_event.dart";
part "hidemode_state.dart";

class HideModeBloc extends Bloc<HideModeEvent,HideModeState>{
  late HideModeRepository hideModeRepository;
  HideModeBloc():super(HideModeInitState()){
    hideModeRepository = HideModeRepository();

    on<ChangeHideModeEvent>(_changeHideMode);
  }

  _changeHideMode(ChangeHideModeEvent event,Emitter<HideModeState> emit )async{
    emit(ChangeHideModeLoadingState());
    try{
      await hideModeRepository.updateHideModeModel(event.hideModeModel);
      HideModeModel hideModeModel = event.hideModeModel.copyWith(isHide: !(event.hideModeModel.isHide??false));
      emit(ChangeHideModeSuccessState(hideModeModel: hideModeModel));
    }catch(e){
      emit(ChangeHideModeErrorState(errorMessage: e.toString()));
    }
  }

}