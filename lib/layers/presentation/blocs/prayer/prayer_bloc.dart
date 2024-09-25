import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/create_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayers.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayers_by_reason.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_praying.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/remove_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/update_prayer.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final CreatePrayer createPrayer;
  final UpdatePrayer updatePrayer;
  final RemovePrayer removePrayer;
  final FindPrayer findPrayer;
  final FindPrayers findPrayers;
  final FindPrayersByReason findPrayersByReason;
  final FindPraying findPraying;

  PrayerBloc({
    required this.createPrayer,
    required this.updatePrayer,
    required this.removePrayer,
    required this.findPrayer,
    required this.findPrayers,
    required this.findPrayersByReason,
    required this.findPraying,
  }) : super(const PrayerInitialState()) {
    on<LoadPrayersEvent>(_loadPrayersEvent);
    on<CreatePrayerEvent>(_createPrayerEvent);
    on<UpdatePrayerEvent>(_updatePrayerEvent);
    on<FindPrayerEvent>(_findPrayerEvent);
    on<DeletePrayerEvent>(_deletePrayerEvent);
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
}
