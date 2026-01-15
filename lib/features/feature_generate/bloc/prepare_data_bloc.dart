// ignore_for_file: camel_case_types

import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

///
/// EVENT
///
abstract class PrepareDataBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrepareDataBlocEvent_pickUltrasoundImageFromGallery
    extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_pickUltrasoundImageFromCamera
    extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_cancelUtrasoundImage
    extends PrepareDataBlocEvent {}

///
/// STATE
///
abstract class PrepareDataBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrepareDataBlocState_loaded extends PrepareDataBlocState {
  final XFile? ultrasoundImage;
  final XFile? motherImage;
  final XFile? fatherImage;
  PrepareDataBlocState_loaded({
    this.ultrasoundImage,
    this.motherImage,
    this.fatherImage,
  });

  @override
  List<Object?> get props => [ultrasoundImage, motherImage, fatherImage];

  PrepareDataBlocState_loaded copyWith({
    XFile? ultrasoundImage,
    XFile? motherImage,
    XFile? fatherImage,
  }) {
    return PrepareDataBlocState_loaded(
      ultrasoundImage: ultrasoundImage ,
      motherImage: motherImage ,
      fatherImage: fatherImage,
    );
  }
}

///
/// BLOC
///
class PrepareDataBloc extends Bloc<PrepareDataBlocEvent, PrepareDataBlocState> {
  final ImagePickerRepository pickerRepository;
  PrepareDataBloc({required this.pickerRepository})
    : super(PrepareDataBlocState_loaded()) {
    ///
    ///  PrepareDataBlocEvent_pickUltrasoundImageFromGallery
    ///
    on<PrepareDataBlocEvent_pickUltrasoundImageFromGallery>((
      event,
      emit,
    ) async {
      final currentState = state;

      if (currentState is PrepareDataBlocState_loaded) {
        final image = await pickerRepository.pickImageFromGallery();
        if (image != null) {
          emit(currentState.copyWith(ultrasoundImage: image));
        }
      }
    });

    ///
    /// PrepareDataBlocEvent_pickUltrasoundImageFromCamera
    ///
    on<PrepareDataBlocEvent_pickUltrasoundImageFromCamera>((event, emit) async{
      final currentState = state;
         if (currentState is PrepareDataBlocState_loaded) {
        final image = await pickerRepository.pickImageFromCamera();
        if (image != null) {
          emit(currentState.copyWith(ultrasoundImage: image));
        }
      }
    });


      ///
    /// PrepareDataBlocEvent_cancelUtrasoundImage
    ///
    on<PrepareDataBlocEvent_cancelUtrasoundImage>((event, emit) async{
      final currentState = state;
         if (currentState is PrepareDataBlocState_loaded) {
           emit(currentState.copyWith(ultrasoundImage: null));
      }
    });
  }
}
