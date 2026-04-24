@isTest
public class TimeTrackerUtilTest {
    @isTest
    public static void isOvertimeTest(){
        System.assert(TimeTrackerUtil.isOvertime(14));
        System.assert(TimeTrackerUtil.isOvertime(12.1));
        System.assertEquals(false, TimeTrackerUtil.isOvertime(3.6));
        System.assertEquals(false, TimeTrackerUtil.isOvertime(7.6));
    }

    @isTest
    public static void formatDurationTest()
    {
        String strTime1 = TimeTrackerUtil.formatDuration(1.5);
        System.assertEquals('1,30m', strTime1);

        String strTime2 = TimeTrackerUtil.formatDuration(4.75);
        System.assertEquals('4,45m',strTime2);

        String strTime3 = TimeTrackerUtil.formatDuration(0.20);
        System.assertEquals('0,12m',strTime3);
    }

}