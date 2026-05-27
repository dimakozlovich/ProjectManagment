@IsTest
public class LogProcessorImplTest {
    
    @TestSetup
    static void makeData() {
        TestDataFactory.createLogsRecords(10);
    }
    
    @IsTest
    static void syncWithDatabaseUpdateTest() {
        List<Time_Log__c> logs = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c];
        List<ClientEntry> clientEnities = new List<ClientEntry>();

        for (Time_Log__c log : logs) {
            log.Status__c = 'Approved';
            clientEnities.add(new ClientEntry(log, 8));
        }
        
        LogProcessorImpl impl = new LogProcessorImpl(clientEnities);
        impl.syncWithDatabase('UPDATE');
        List<Time_Log__c> UpdatedLogs = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c 
                                         WHERE Status__c = 'Approved'];
        
        Assert.areEqual(9, UpdatedLogs.size(), 'exptected 9 logs but actual is' + UpdatedLogs.size());
    }
    
    @IsTest
    static void syncWithDatabaseDeleteTest() {
        List<Time_Log__c> logs = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c];
        List<ClientEntry> clientEnities = new List<ClientEntry>();

        for (Time_Log__c log : logs) {
            clientEnities.add(new ClientEntry(log, 8));
        }
        
        LogProcessorImpl impl = new LogProcessorImpl(clientEnities);
        impl.syncWithDatabase('DELETE');
        List<Time_Log__c> UpdatedLogs = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c];
        
        Assert.areEqual(0, UpdatedLogs.size(), 'exptected 0 logs but actual is' + UpdatedLogs.size());
    }

    @IsTest
    static void debugTotalHoursLogsTest() {
        List<Time_Log__c> logs = [SELECT Id, Date__c, Duration__c, Description__c FROM Time_Log__c];
        List<ClientEntry> clientEnities = new List<ClientEntry>();

        for (Time_Log__c log : logs) {
            clientEnities.add(new ClientEntry(log, 8));
        }
        
        LogProcessorImpl impl = new LogProcessorImpl(clientEnities);

        Assert.areEqual(475.20, impl.debugTotalHoursLogs(), 'exptected 475.20 but actual is' + impl.debugTotalHoursLogs());
    }
}