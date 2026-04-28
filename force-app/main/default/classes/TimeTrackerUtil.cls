public with sharing class TimeTrackerUtil {
  private static final Integer MAX_HOURS_PER_DAY = 24;
  private static final Integer DEFAULT_WORK_DAY = 8;

  public static Boolean isOvertime(Decimal hours) {
    validateHours(hours);

    if (hours > DEFAULT_WORK_DAY) {
      return true;
    }
    return false;
  }

  public static String formatDuration(Decimal hours) {
    validateHours(hours);

    Integer minutes = Integer.valueOf(hours * 60);
    Integer wholeHour = Integer.valueOf(minutes / 60);
    Integer remainingMinutes = Math.mod(minutes, 60);

    return String.valueOf(wholeHour) +
      ',' +
      String.valueOf(remainingMinutes) +
      'm';
  }

  private static void validateHours(Decimal hours) {
    if (hours > MAX_HOURS_PER_DAY || hours == 0 || hours < 0 || hours == null) {
      throw new IllegalArgumentException('Invalid hours value');
    }
  }
}
