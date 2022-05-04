import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart' as prefix0;

class CalendarListEventModel {
  List<Event>? primaryEvents;
  List<Event>? secondaryEvents;
  String? tithi;
  prefix0.Calendar? calendar;
  String? chandrama;

  CalendarListEventModel(
      {this.primaryEvents,
      this.secondaryEvents,
      this.tithi = "",
      this.chandrama = "",
      this.calendar});

  getPrimaryEvents() => primaryEvents;

  getSecondaryEvents() => secondaryEvents;

  getTithi() => tithi;

  getChandrama() => chandrama;
}
