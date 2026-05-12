public abstract class BaseEntryType implements Comparable {
    public Time_Log__c logRecord;
    protected Decimal hourlyRate;
    
    public BaseEntryType(Time_Log__c logRecord, Decimal hourlyRate) {
        this.logRecord = logRecord;
        this.hourlyRate = hourlyRate;
    }
    
    protected abstract String getEntryCategory();
    protected virtual Decimal calculateTotalCost() {
        return logRecord.Duration__c * hourlyRate;
    }
    
    public Integer compareTo(Object obj) {
        BaseEntryType compareLogRecord = (BaseEntryType)obj;
        
        if (this.logRecord.Date__c != compareLogRecord.logRecord.Date__c) {
            return this.logRecord.Date__c > compareLogRecord.logRecord.Date__c ? 1 : -1;
        }
        if (this.logRecord.Date__c == compareLogRecord.logRecord.Date__c) {
            return this.logRecord.Duration__c > compareLogRecord.logRecord.Duration__c ? 1 : -1;
        }
        return 0;
    }
    
}