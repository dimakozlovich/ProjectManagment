@IsTest
public class TimeLogAuditorBatchTest {

    @TestSetup
    static void setup() {
        TestDataFactory.createLogsRecords(201);
    }
    
    @IsTest
    static void testBatchExecution() {
        Test.startTest();
        Database.executeBatch(new TimeLogAuditorBatch());
        Test.stopTest();
        
        Integer rejectedCount = [SELECT count() FROM Time_Log__c WHERE Status__c = 'Rejected'];
        System.assertEquals(100, rejectedCount);
    }
}