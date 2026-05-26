@isTest
public class ClientEntryTest {

    @testSetup
    static void makeData() {
        TestDataFactory.createLogsRecords(2);
    }

    @isTest
    static void getEntryCategoryTest() {
         ClientEntry clientEntry = getClientEntryInstance();
         Assert.areEqual('Billable', clientEntry.getEntryCategory());
    }

    @isTest
    static void calculateTotalCostTest() {
         ClientEntry clientEntry = getClientEntryInstance();
         Assert.areEqual(4.4, clientEntry.calculateTotalCost());
    }

    @isTest
    private static ClientEntry getClientEntryInstance() {
        Time_Log__c log = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c LIMIT 1];
        return new ClientEntry(log, 2);
    }
}