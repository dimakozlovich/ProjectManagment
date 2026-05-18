public class TimeLogAuditorBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    public Decimal totalRejectedHours = 0.0;
    public Integer totalRejectedLogs = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Description__c, Duration__c, Status__c ' +
                       'FROM Time_Log__c ' +
                       'WHERE Status__c = \'Submitted\' AND Date__c = THIS_MONTH';
        
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Time_Log__c> scope) {
        List<Time_Log__c> logsToUpdate = new List<Time_Log__c>();
        
        for (Time_Log__c log : scope) {
            Integer wordCount = 0;
            
            if (String.isNotBlank(log.Description__c)) {
                wordCount = log.Description__c.normalizeSpace().split(' ').size();
            }
            
            if (wordCount < 5) {
                log.Status__c = 'Rejected';
                logsToUpdate.add(log);
                
                if (log.Duration__c != null) {
                    totalRejectedHours += log.Duration__c;
                }
                totalRejectedLogs++;
            }
        }
        
        if (!logsToUpdate.isEmpty()) {
            update logsToUpdate;
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Total logs rejected: ' + totalRejectedLogs);
        System.debug('Total hours rejected: ' + totalRejectedHours);
    }
}