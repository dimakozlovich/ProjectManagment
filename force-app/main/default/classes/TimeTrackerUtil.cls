public with sharing class TimeTrackerUtil {
  private static final Integer MAX_HOURS_PER_DAY = 24;
  private static final Integer DEFAULT_WORK_DAY = 8;

  public static Boolean isOvertime(Decimal hours) {
    if (hours > DEFAULT_WORK_DAY) {
      return true;
    }
    return false;
  }
  public static String formatDuration(Decimal hours) {
    Integer minutes = Integer.valueOf(hours * 60);
    Integer wholeHour = Integer.valueOf(minutes / 60);
    return String.valueOf(minutes / 60) +
      ',' +
      String.valueOf(minutes - wholeHour * 60) +
      'm';
  }
}
