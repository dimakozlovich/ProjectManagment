@isTest
public class TimeLogAuditorBatchTest {

    @testSetup
    static void setup() {
        TestDataFactory.createLogsRecords(201);
    }
    
    @isTest
    static void testBatchExecution() {
        Test.startTest();
        Database.executeBatch(new TimeLogAuditorBatch());
        Test.stopTest();
        
        Integer rejectedCount = [SELECT count() FROM Time_Log__c WHERE Status__c = 'Rejected'];
        System.assertEquals(100, rejectedCount);
    }
}