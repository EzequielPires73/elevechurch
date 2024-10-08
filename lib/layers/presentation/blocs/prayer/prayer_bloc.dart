import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/change_praying.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/create_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_my_prayers.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayers.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayers_by_reason.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_praying.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/remove_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/update_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer_comment/create_prayer_comment.dart';
import 'package:elevechurch/layers/domain/usecases/prayer_comment/remove_prayer_comment.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final CreatePrayer createPrayer;
  final UpdatePrayer updatePrayer;
  final RemovePrayer removePrayer;
  final FindPrayer findPrayer;
  final FindPrayers findPrayers;
  final FindMyPrayers findMyPrayers;
  final FindPrayersByReason findPrayersByReason;
  final FindPraying findPraying;
  final ChangePraying changePraying;
  final CreatePrayerComment createPrayerComment;
  final RemovePrayerComment removePrayerComment;

  PrayerBloc({
    required this.createPrayer,
    required this.updatePrayer,
    required this.removePrayer,
    required this.findPrayer,
    required this.findPrayers,
    required this.findMyPrayers,
    required this.findPrayersByReason,
    required this.findPraying,
    required this.changePraying,
    required this.createPrayerComment,
    required this.removePrayerComment,
  }) : super(const PrayerInitialState()) {
    on<LoadPrayersEvent>(_loadPrayersEvent);
    on<LoadPrayingEvent>(_loadPrayingEvent);
    on<LoadMyPrayersEvent>(_loadMyPrayersEvent);
    on<CreatePrayerEvent>(_createPrayerEvent);
    on<UpdatePrayerEvent>(_updatePrayerEvent);
    on<FindPrayerEvent>(_findPrayerEvent);
    on<DeletePrayerEvent>(_deletePrayerEvent);
    on<ChangePrayingEvent>(_changePrayingEvent);
    on<CreatePrayerCommentEvent>(_createPrayerCommentEvent);
    on<RemovePrayerCommentEvent>(_removePrayerCommentEvent);
  }

  Future<void> _loadPrayersEvent(
      LoadPrayersEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      List<Prayer> prayers = await findPrayers.call();
      emit(PrayersLoadedState(prayers: prayers));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _loadPrayingEvent(
      LoadPrayingEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      List<Prayer> prayers = await findPraying.call();
      emit(PrayingLoadedState(prayers: prayers));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _loadMyPrayersEvent(
      LoadMyPrayersEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      List<Prayer> prayers = await findMyPrayers.call();
      emit(MyPrayersLoadedState(prayers: prayers));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _createPrayerEvent(
      CreatePrayerEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      Prayer prayer = await createPrayer.call(event.prayer);
      emit(PrayerCreatedState(prayer: prayer));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _updatePrayerEvent(
      UpdatePrayerEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      Prayer prayer = await updatePrayer.call(event.id, event.prayer);
      emit(PrayerUpdatedState(prayer: prayer));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _findPrayerEvent(
      FindPrayerEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      Prayer prayer = await findPrayer.call(event.id);
      emit(PrayerFoundState(prayer: prayer));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _deletePrayerEvent(
      DeletePrayerEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      await removePrayer.call(event.id);
      emit(PrayerRemovededState());
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _changePrayingEvent(
      ChangePrayingEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerCardLoadingState(
      id: event.id,
    ));
    try {
      await changePraying.call(event.id);
      if (event.listMyPrayers == true) {
        List<Prayer> prayers = await findMyPrayers.call();
        emit(MyPrayersLoadedState(prayers: prayers));
      } else if (event.listPraying == true) {
        List<Prayer> prayers = await findPraying.call();
        emit(PrayingLoadedState(prayers: prayers));
      } else if (event.viewPrayer == true) {
        List<Prayer> prayers = await findPrayers.call();
        Prayer prayer = await findPrayer(event.id);
        emit(PrayerFoundState(prayer: prayer, prayers: prayers));
      } else {
        List<Prayer> prayers = await findPrayers.call();
        emit(PrayersLoadedState(prayers: prayers));
      }
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _createPrayerCommentEvent(
      CreatePrayerCommentEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      await createPrayerComment.call(
        event.id,
        event.message,
      );

      Prayer prayer = await findPrayer.call(event.id);

      emit(PrayerFoundState(prayer: prayer));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }

  Future<void> _removePrayerCommentEvent(
      RemovePrayerCommentEvent event, Emitter<PrayerState> emit) async {
    emit(PrayerLoadingState());
    try {
      await removePrayerComment.call(
        event.commentId,
      );

      Prayer prayer = await findPrayer.call(event.prayerId);
      List<Prayer> prayers = await findPrayers.call();

      emit(PrayerFoundState(prayer: prayer, prayers: prayers));
    } catch (e) {
      emit(PrayerErrorState(error: e.toString()));
    }
  }
}
