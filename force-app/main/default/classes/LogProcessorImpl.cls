public class LogProcessorImpl implements LogProcessorInterface {
    
    private List<BaseEntryType> entries;
    
    public LogProcessorImpl(List<BaseEntryType> listEntries) {
        if (listEntries == null) {
            throw new IllegalArgumentException('LogProcessor cannot be initialized with a null list.');
        }
        
        listEntries.sort();
        this.entries = listEntries;
    }
    
    public void debugTotalHoursLogs() {
        Decimal totalHours = 0.0;
        
        for (BaseEntryType entry : this.entries) {
            if (entry.calculateTotalCost() != null) {
                totalHours += entry.calculateTotalCost();
            }
        }
        
        System.Debug(totalHours);
    }
    public void processData(){}
    public void syncWithDatabase(){}
}