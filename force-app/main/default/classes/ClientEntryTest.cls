@IsTest
public class ClientEntryTest {

    @TestSetup
    static void makeData() {
        TestDataFactory.createLogsRecords(2);
    }

    @IsTest
    static void getEntryCategoryTest() {
         ClientEntry clientEntry = getClientEntryInstance();
         Assert.areEqual('Billable', clientEntry.getEntryCategory());
    }

    @IsTest
    static void calculateTotalCostTest() {
         ClientEntry clientEntry = getClientEntryInstance();
         Assert.areEqual(4.4, clientEntry.calculateTotalCost());
    }

    private static ClientEntry getClientEntryInstance() {
        Time_Log__c log = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c LIMIT 1];
        return new ClientEntry(log, 2);
    }
}