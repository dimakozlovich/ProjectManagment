
@IsTest
public class InternalEntryTest {
    
   @TestSetup
    static void makeData() {
        TestDataFactory.createLogsRecords(2);
    }

    @IsTest
    static void getEntryCategoryTest() {
         InternalEntry internalEntry = getInternalEntryInstance();
         Assert.areEqual('Non-Billable', internalEntry.getEntryCategory());
    }

    @IsTest
    static void calculateTotalCostTest() {
         InternalEntry internalEntry = getInternalEntryInstance();
         Assert.areEqual(0, internalEntry.calculateTotalCost());
    }

    private static InternalEntry getInternalEntryInstance() {
        Time_Log__c log = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c LIMIT 1];
        return new InternalEntry(log, 2);
    }
    
}