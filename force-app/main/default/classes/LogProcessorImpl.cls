public class LogProcessorImpl {
    
    public List<BaseEntryType> entries;
    
    public LogProcessorImpl(List<BaseEntryType> listEntries) {
        listEntries.sort();
        this.entries = listEntries;
    }
    
    public void debugTotalHoursLogs() {
        Decimal totalHours = 0.0;
        
        for (BaseEntryType entry : this.entries) {
            if (entry.logRecord != null && entry.logRecord.Duration__c != null) {
                totalHours += entry.logRecord.Duration__c;
            }
        }
        
        System.Debug(totalHours);
    }
}