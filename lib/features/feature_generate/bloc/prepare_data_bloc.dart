// ignore_for_file: camel_case_types

import 'package:baby_look/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:baby_look/core/app_enum/baby_gender.dart';
import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';

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

class PrepareDataBlocEvent_cancelUtrasoundImage extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_setGestationWeek extends PrepareDataBlocEvent {
  final int value;
  PrepareDataBlocEvent_setGestationWeek({required this.value});
  @override
  List<Object?> get props => [value];
}

class PrepareDataBlocEvent_setGender extends PrepareDataBlocEvent {
  final BABY_GENDER value;
  PrepareDataBlocEvent_setGender({required this.value});
  @override
  List<Object?> get props => [value];
}

class PrepareDataBlocEvent_pickMotherImageFromGallery
    extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_pickMotherImageFromCamera
    extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_cancelMotherImage extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_pickFatherImageFromGallery
    extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_pickFatherImageFromCamera
    extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_cancelFatherImage extends PrepareDataBlocEvent {}

class PrepareDataBlocEvent_cancelAll extends PrepareDataBlocEvent {}

///
/// STATE
///
abstract class PrepareDataBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrepareDataBlocState_initial extends PrepareDataBlocState {}

class PrepareDataBlocState_loaded extends PrepareDataBlocState {
  final XFile? ultrasoundImage;
  final XFile? motherImage;
  final XFile? fatherImage;
  final int? gestationWeek;
  final BABY_GENDER babyGender;
  PrepareDataBlocState_loaded({
    this.ultrasoundImage,
    this.motherImage,
    this.fatherImage,
    this.gestationWeek,
    this.babyGender = BABY_GENDER.DONT_KNOW,
  });

  @override
  List<Object?> get props => [
    ultrasoundImage,
    motherImage,
    fatherImage,
    gestationWeek,
    babyGender,
  ];

  PrepareDataBlocState_loaded copyWith({
    XFile? ultrasoundImage,
    XFile? motherImage,
    XFile? fatherImage,
    int? gestationWeek,
    BABY_GENDER? babyGender,
    bool clearUltrasound = false,
    bool clearMother = false,
    bool clearFather = false,
    bool clearGestation = false,
    bool clearGender = false,
  }) {
    return PrepareDataBlocState_loaded(
      ultrasoundImage: clearUltrasound
          ? null
          : (ultrasoundImage ?? this.ultrasoundImage),
      motherImage: clearMother ? null : (motherImage ?? this.motherImage),
      fatherImage: clearFather ? null : (fatherImage ?? this.fatherImage),
      gestationWeek: clearGestation
          ? null
          : (gestationWeek ?? this.gestationWeek),
      babyGender: clearGender
          ? BABY_GENDER.DONT_KNOW
          : (babyGender ?? this.babyGender),
    );
  }
}

///
/// BLOC
///
class PrepareDataBloc extends Bloc<PrepareDataBlocEvent, PrepareDataBlocState> {
  final ImagePickerRepository pickerRepository;
  PrepareDataBloc({required this.pickerRepository})
    : super(PrepareDataBlocState_loaded(babyGender: BABY_GENDER.DONT_KNOW)) {
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
    on<PrepareDataBlocEvent_pickUltrasoundImageFromCamera>((event, emit) async {
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
    on<PrepareDataBlocEvent_cancelUtrasoundImage>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        emit(currentState.copyWith(clearUltrasound: true));
      }
    });

    ///
    /// PrepareDataBlocEvent_setGestationWeek
    ///
    on<PrepareDataBlocEvent_setGestationWeek>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        emit(currentState.copyWith(gestationWeek: event.value));
        logger.i('Current Week: ${event.value}');
      }
    });

    ///
    /// PrepareDataBlocEvent_setGender
    ///
    on<PrepareDataBlocEvent_setGender>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        emit(currentState.copyWith(babyGender: event.value));
        logger.i('Current Gender: ${event.value}');
      }
    });

    ///
    ///  PrepareDataBlocEvent_pickMotherImageFromGallery
    ///
    on<PrepareDataBlocEvent_pickMotherImageFromGallery>((event, emit) async {
      final currentState = state;

      if (currentState is PrepareDataBlocState_loaded) {
        final image = await pickerRepository.pickImageFromGallery();
        if (image != null) {
          emit(currentState.copyWith(motherImage: image));
        }
      }
    });

    ///
    /// PrepareDataBlocEvent_pickMotherImageFromCamera
    ///
    on<PrepareDataBlocEvent_pickMotherImageFromCamera>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        final image = await pickerRepository.pickImageFromCamera();
        if (image != null) {
          emit(currentState.copyWith(motherImage: image));
        }
      }
    });

    ///
    /// PrepareDataBlocEvent_cancelMotherImage
    ///
    on<PrepareDataBlocEvent_cancelMotherImage>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        emit(currentState.copyWith(clearMother: true));
      }
    });

    ///
    ///  PrepareDataBlocEvent_pickFatherImageFromGallery
    ///
    on<PrepareDataBlocEvent_pickFatherImageFromGallery>((event, emit) async {
      final currentState = state;

      if (currentState is PrepareDataBlocState_loaded) {
        final image = await pickerRepository.pickImageFromGallery();
        if (image != null) {
          emit(currentState.copyWith(fatherImage: image));
        }
      }
    });

    ///
    /// PrepareDataBlocEvent_pickFatherImageFromCamera
    ///
    on<PrepareDataBlocEvent_pickFatherImageFromCamera>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        final image = await pickerRepository.pickImageFromCamera();
        if (image != null) {
          emit(currentState.copyWith(fatherImage: image));
        }
      }
    });

    ///
    /// PrepareDataBlocEvent_cancelFatherImage
    ///
    on<PrepareDataBlocEvent_cancelFatherImage>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        emit(currentState.copyWith(clearFather: true));
      }
    });

    ///
    /// PrepareDataBlocEvent_cancelAll
    ///
    on<PrepareDataBlocEvent_cancelAll>((event, emit) async {
      final currentState = state;
      if (currentState is PrepareDataBlocState_loaded) {
        emit(PrepareDataBlocState_initial());
        emit(PrepareDataBlocState_loaded());
      }
    });
  }
}
