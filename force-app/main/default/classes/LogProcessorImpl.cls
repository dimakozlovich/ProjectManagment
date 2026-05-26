public class LogProcessorImpl implements LogProcessorInterface {
    
    private List<BaseEntryType> entries;
    
    public LogProcessorImpl(List<BaseEntryType> listEntries) {
        if (listEntries == null) {
            throw new IllegalArgumentException('LogProcessor cannot be initialized with a null list.');
        }
        
        listEntries.sort();
        this.entries = listEntries;
    }
    
    public Decimal debugTotalHoursLogs() {
        Decimal totalHours = 0.0;
        
        for (BaseEntryType entry : this.entries) {
            if (entry.calculateTotalCost() != null) {
                totalHours += entry.calculateTotalCost();
            }
        }

        System.Debug(totalHours);
        return totalHours;
    }
    
    public List<Time_Log__c> processData(String operationType) {
        List<Time_Log__c> processedLogs = new List<Time_Log__c>();
        
        for (BaseEntryType record : entries) {
            Time_Log__c log = record.getRecord();
            
            if ((log.Id == null)
                || log.Description__c == null
                || log.Duration__c == null
                || log.Date__c == null) {
                    throw new IllegalArgumentException('Cannot process Time Log. Missing required fields (Id, Description, Duration, or Date) for record: ' + log);
            }
            
            processedLogs.add(log);
        }
        
        return processedLogs;
    }
    
    public void syncWithDatabase(String operationType) {
        if (String.isBlank(operationType)) {
            throw new IllegalArgumentException('Empty DML type');
        }
        
        List<Time_Log__c> logsToUpdate = processData(operationType);
        
        switch on operationType {
            when 'UPDATE' {
                update logsToUpdate;
            }
            when 'DELETE' {
                delete logsToUpdate;
            }
        }
    }
}