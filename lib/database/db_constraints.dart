// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

class RasifalTable {
  static final type = 'type';
  static final title = 'title';
  static final author = 'author';
  static final lang = 'lang';
  static final aries = 'aries';
  static final taurus = 'taurus';
  static final gemini = 'gemini';
  static final cancer = 'cancer';
  static final leo = 'leo';
  static final virgo = 'virgo';
  static final libra = 'libra';
  static final scorpio = 'scorpio';
  static final sagittarius = 'sagittarius';
  static final capricorn = 'capricorn';
  static final aquarius = 'aquarius';
  static final pisces = 'pisces';
  static final todate = 'todate';
}

class BlogTable {
  static final id = 'id';
  static final date = 'date';
  static final modified = 'modified';
  static final url = 'url';
  static final title = 'title';
  static final content = 'content';
  static final excerpt = 'excerpt';
  static final thumbnail = 'thumbnail';
  static final categories = 'categories';
  static final tags = 'tags';
  static final author = 'author';
  static final comments = 'comments';
  static final comment_count = 'comment_count';
  static final thumbnail_images = 'thumbnail_images';
  static final readdate = 'readdate';
  static final isread = 'isread';
  static final ignore = 'ignore';
  static final event = 'event';
}

class CalendarTable {
  static final id = 'id';
  static final name = 'name';
  static final status = 'status';
  static final calendar_id = 'calendar_id';
  static final is_modifiable = 'is_modifiable';
  static final created_by = 'created_by';
  static final is_default = 'is_default';
  static final created_at = 'created_at';
  static final updated_at = 'updated_at';
  static final color = 'color';
  static final priority = 'priority';
  static final display = 'display';
}

class AMessageTable {
  static final id = 'id';
  static final message_np = 'message_np';
  static final message_en = 'message_en';
  static final linktype = 'linktype';
  static final link = 'link';
  static final stdate = 'stdate';
  static final expiry = 'expiry';
  static final aflag = 'aflag';
  static final pin = 'pin';
  static final createdAt = 'createdAt';
  static final enable = 'enable';
  static final options = 'options';
  static final dorder = 'dorder';
  static final cancelled = 'cancelled';
}

class EventsTable {
  static final id = 'id';
  static final parent_event_id = 'parent_event_id';
  static final title = 'title';
  static final description = 'description';
  static final start_date = 'start_date';
  static final end_date = 'end_date';
  static final is_full_day_event = 'is_full_day_event';
  static final recurring_end_date = 'recurring_end_date';
  static final is_recurring = 'is_recurring';
  static final created_by = 'created_by';
  static final has_reminder = 'has_reminder';
  static final location = 'location';
  static final guests = 'guests';
  static final rsvp = 'rsvp';
  static final note = 'note';
  static final event_permission = 'event_permission';
  static final visibility = 'visibility';
  static final privacy = 'privacy';
  static final status = 'status';
  static final duration = 'duration';
  static final gh = 'gh';
  static final important_event = 'important_event';
  static final rrule = 'rrule';
  static final deleted_at = 'deleted_at';
  static final created_at = 'created_at';
  static final updated_at = 'updated_at';
  static final calendar_id = 'calendar_id';
  static final based_on = 'based_on';
  static final rsvp_stats = 'rsvp_stats';
  static final formatted_rrule = 'formatted_rrule';
  static final rsstart = 'rsstart';
  static final origid = 'origid';
}

class HolidaysTable {
  static final id = 'id';
  static final eventId = 'eventId';
  static final eventDate = 'eventDate';
  static final holidayType = 'holidayType';
  static final status = 'status';
  static final createdAt = 'createdAt';
  static final updatedAt = 'updatedAt';
  static final deletedAt = 'deletedAt';
}

class ExceptionsTable {
  static final id = 'id';
  static final exception_date = 'exception_date';
  static final new_date = 'new_date';
  static final event_id = 'event_id';
  static final created_at = 'created_at';
  static final updated_at = 'updated_at';
  static final calendar_id = 'calendar_id';
}

class RemindersTable {
  static final id = 'id';
  static final event_id = 'event_id';
  static final days = 'days';
  static final time = 'time';
  static final note = 'note';
  static final notification_type = 'notification_type';
  static final updated_at = 'updated_at';
  static final created_at = 'created_at';
}

class ForexTable {
  static final id = 'id';
  static final fordate = 'fordate';
  static final source = 'source';
  static final source_url = 'source_url';
}

class ForexDetailTable {
  static final id = 'id';
  static final pid = 'pid';
  static final type = 'type';
  static final code = 'code';
  static final currency = 'currency';
  static final unit = 'unit';
  static final buying = 'buying';
  static final selling = 'selling';
}

class PanchangaDb {
  static final id = 'id';
  static final date = 'date';
  static final text_np = 'text_np';
  static final text_en = 'text_en';
  static final text_ddnp = 'text_ddnp';
  static final text_dden = 'text_dden';
}

class CacheDb {
  static final id = 'id';
  static final date = 'date';
  static final event_id = 'event_id';
  static final created_at = 'created_at';
  static final updated_at = 'updated_at';
}

class DeletedEvent {
  static final id = 'id';
  static final event_id = 'event_id';
  static final calendar_id = 'calendar_id';
  static final created_at = 'created_at';
  static final updated_at = 'updated_at';
}

class DeletedReminder {
  static final id = 'id';
  static final reminder_id = 'reminder_id';
  static final event_id = 'event_id';
  static final created_at = 'created_at';
  static final updated_at = 'updated_at';
}

//##.....................Times Of Nepal ................................##//

class FeedsTable {
  static final id = 'id';
  static final newsId = 'newsId';
  static final title = 'title';
  static final description = 'description';
  static final content = 'content';
  static final link = 'link';
  static final enclosure_url = 'enclosure_url';
  static final enclosure_type = 'enclosure_type';
  static final source = 'source';
  static final category = 'category';
  static final author = 'author';
  static final image = 'image';
  static final uuid = 'uuid';
  static final fetchDate = 'fetchDate';
  static final pub_date = 'pub_date';
  static final update_date = 'update_date';
  static final read = 'read';
  static final bookmarked = 'bookmarked';
}

class RelatedFeedsTable {
  static final id = 'id';
  static final pId = 'pId';
  static final title = 'title';
  static final description = 'description';
  static final content = 'content';
  static final link = 'link';
  static final enclosure_url = 'enclosure_url';
  static final enclosure_type = 'enclosure_type';
  static final source = 'source';
  static final category = 'category';
  static final author = 'author';
  static final image = 'image';
  static final uuid = 'uuid';
  static final fetchDate = 'fetchDate';
  static final pub_date = 'pub_date';
  static final update_date = 'update_date';
  static final read = 'read';
  static final bookmarked = 'bookmarked';
}

class SourcesTable {
  static final id = 'id';
  static final name = 'name';
  static final name_np = 'name_np';
  static final code = 'code';
  static final icon = 'icon';
  static final lang = 'lang';
  static final priority = 'priority';
  static final favicon = 'favicon';
  static final ga = 'ga';
}

class CategoriesTable {
  static final id = 'id';
  static final name = 'name';
  static final name_np = 'name_np';
  static final code = 'code';
  static final icon = 'icon';
  static final enable = 'enable';
  static final priority = 'priority';
}

class BookmarkTable {
  static final id = 'id';
  static final pId = 'pId';
  static final title = 'title';
  static final description = 'description';
  static final content = 'content';
  static final link = 'link';
  static final enclosure_url = 'enclosure_url';
  static final enclosure_type = 'enclosure_type';
  static final source = 'source';
  static final category = 'category';
  static final author = 'author';
  static final image = 'image';
  static final uuid = 'uuid';
  static final fetchDate = 'fetchDate';
  static final pub_date = 'pub_date';
  static final update_date = 'update_date';
  static final read = 'read';
  static final bookmarked = 'bookmarked';
}
