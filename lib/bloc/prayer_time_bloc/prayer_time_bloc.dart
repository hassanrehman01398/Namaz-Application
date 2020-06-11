import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz/bloc/prayer_time_bloc/prayer_time_event.dart';
import 'package:namaz/bloc/prayer_time_bloc/prayer_time_state.dart';
import 'package:namaz/model/prayer_time_model.dart';

class PrayerTimeBloc extends Bloc<PrayerTimeEvent, PrayerTimeState> {
  @override
  PrayerTimeState get initialState => PrayerTimeEmpty();

  @override
  Stream<PrayerTimeState> mapEventToState(PrayerTimeEvent event) async* {
    if (event is PrayerTimeFetch) {
      yield PrayerTimeLoading();
      try {
        PrayerTimeModel model = PrayerTimeModel.fromDateAndCoordinates(
            date: event.date,
            latitude: event.location.latitude,
            longitude: event.location.longitude,
            timezone: event.date.timeZoneOffset.inHours.toDouble());
        if (model == null) {
          yield PrayerTimeEmpty();
        } else
          yield PrayerTimeLoaded(model);
      } catch (e) {
        print("PrayerTimeBloc error: $e");
        yield PrayerTimeError();
      }
    }
  }
}
