// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/amessage_model.dart';
import 'package:nepali_patro_sql_package/models/amessage_option_model.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/models/rasifal_model.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart'
    as prefix0;
import 'package:nepali_patro_sql_package/utils/utils.dart';
//rashifal

Np rashifal = Np(
    type: 'HelloDevp',
    title: 'heloTest',
    author: 'Test author',
    lang: 'en',
    aries: 'aries',
    taurus: null,
    gemini: null,
    cancer: null,
    leo: null,
    virgo: null,
    libra: null,
    scorpio: null,
    sagittarius: null,
    capricorn: null,
    aquarius: null,
    pisces: null,
    todate: null);

//amessage
Content messagecontent = Content(
  id: '1',
  messageNp: 'hi np',
  messageEn: 'hi en',
  linktype: 'typeone',
  link: 'www.google.com.np',
  stdate: DateTime(2021, 06, 2),
  expiry: '30-06-2121',
  aflag: 'hi flag',
  pin: '2222',
  enable: 'yes',
  options: AMessageOption(
    footer_action_text: 'hi',
    image: 'hello.png',
    thumbnail: 'thumbnail.png',
    subtitle: Title(en: 'en'),
    title: Title(en: 'en'),
  ),
  dorder: 'hi dorder',
  cancelled: 0,
);

Event eventsDataWithdecriptDesc = Event(
    id: '1',
    parentEventId: '1',
    title: 'hi title ',
    description: Utils.decryptData(
        "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0="),
    startDate: DateTime.parse("2019-10-30"),
    endDate: DateTime.parse("2019-10-30"),
    isFullDayEvent: 0,
    recurringEndDate: DateTime.parse("2019-10-30"),
    isRecurring: 1,
    createdBy: 'developer',
    hasReminder: 0,
    location: 'ktm',
    guests: [],
    rsvp: null,
    note: 'note one',
    eventPermission: [],
    visibility: 'visibility',
    privacy: 'privacy',
    status: 0,
    duration: 1,
    gh: 0,
    imp: 0,
    rrule: 'rule',
    deletedAt: "2019-10-30",
    createdAt: DateTime.parse("2019-10-30"),
    updatedAt: DateTime.parse("2019-10-30"),
    calendar_id: '1',
    basedOn: "user",
    rsvpStats: null,
    formattedRrule: null,
    rsstart: DateTime.parse("2019-10-30"),
    origid: 22);

Event eventsData = Event(
    id: '1',
    parentEventId: '1',
    title: 'hi title ',
    description:
        "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0=",
    startDate: DateTime.parse("2019-10-30"),
    endDate: DateTime.parse("2019-10-30"),
    isFullDayEvent: 0,
    recurringEndDate: DateTime.parse("2019-10-30"),
    isRecurring: 1,
    createdBy: 'developer',
    hasReminder: 0,
    location: 'ktm',
    guests: [],
    rsvp: null,
    note: 'note one',
    eventPermission: [],
    visibility: 'visibility',
    privacy: 'privacy',
    status: 0,
    duration: 1,
    gh: 0,
    imp: 0,
    rrule: 'rule',
    deletedAt: "2019-10-30",
    createdAt: DateTime.parse("2019-10-30"),
    updatedAt: DateTime.parse("2019-10-30"),
    calendar_id: '1',
    basedOn: "user",
    rsvpStats: null,
    formattedRrule: null,
    rsstart: DateTime.parse("2019-10-30"),
    origid: 22);

//eventexception

List<dynamic> eventexception = [
  {
    EventsExcDb.id: '1',
    EventsExcDb.exception_date: "2011-10-03",
    EventsExcDb.new_date: "2011-10-03",
    EventsExcDb.event_id: '1',
    EventsExcDb.created_at: "2011-10-03",
    EventsExcDb.updated_at: "2011-10-03",
    EventsExcDb.calendar_id: '1'
  }
];

List<prefix0.Event> cacheparameter = [
  prefix0.Event(
      id: '1',
      parentEventId: '1',
      title: 'hi title ',
      description:
          "eyJpdiI6IitcL1RkbVdBYmFRYTN1dHRIQnNrSk53PT0iLCJ2YWx1ZSI6InFrZzNYMEl0UWRZb3crSEQ4ZVhudlBYOTdHYklPcTZINFwvZGpoZjYzVWhVbG0rK04wd3hvR0xkN2dEV0p6QUJsS1Z0WXV0c1Y4Q1c5TGc1ejlTUklnRXpUV1lSRDVnYU5aUlh6ZDcrcHhDazBwdnREXC9LSkZwSkpGb0dCejU5VW94V25remlCYytzSStXa3JQdDk0U2hFRjZtblwvVzFzcDVaZWx2YlwvNDJqek1Od3MwS1VHeTNCNm1vYUVhd2IzMlFIa3NyeWYwSXI5XC9YN0VxQ29SVDlWSnhMa2R3NFNSMWVrMXN6czk3azNHNmpDMFNUMTVWV1EyXC9lOXljK0tuYlREdUdDcFRkSDU1UmtOdXQ0bWlSaWhBPT0iLCJtYWMiOiI2ZjdlMGNhNjJlMmNkN2UwZmZkOWQ1YTJhMDdkN2ZmNzUzNjMyNzNlMDE3OWI1OGNlMDEwMDk0YmU3OTMxZWY0In0=",
      startDate: DateTime.parse("2019-10-30"),
      endDate: DateTime.parse("2019-10-30"),
      isFullDayEvent: 0,
      recurringEndDate: DateTime.parse("2019-10-30"),
      isRecurring: 1,
      createdBy: 'developer',
      hasReminder: 0,
      location: 'ktm',
      guests: const [],
      rsvp: null,
      note: 'note one',
      eventPermission: const [],
      visibility: 'visibility',
      privacy: 'privacy',
      status: 0,
      duration: 1,
      gh: 0,
      imp: 0,
      rrule: 'rule',
      deletedAt: "2019-10-30",
      createdAt: DateTime.parse("2019-10-30"),
      updatedAt: DateTime.parse("2019-10-30"),
      calendar_id: '1',
      basedOn: "user",
      rsvpStats: null,
      formattedRrule: null,
      rsstart: DateTime.parse("2019-10-30"),
      origid: 22)
];
