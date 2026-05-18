public abstract class BaseEntryType implements Comparable {
    
    protected Time_Log__c logRecord;
    protected Decimal hourlyRate;
    
    public BaseEntryType(Time_Log__c logRecord, Decimal hourlyRate) {
        this.logRecord = logRecord;
        this.hourlyRate = hourlyRate;
    }
    
    public abstract String getEntryCategory();
    
    public virtual Decimal calculateTotalCost() {
        if (logRecord.Duration__c == null || hourlyRate == null) {
            throw new IllegalArgumentException('Duration or Hourly Rate cannot be null for cost calculation.');
        }
        
        return logRecord.Duration__c * hourlyRate;
    }
    
    public Integer compareTo(Object obj) {
        BaseEntryType compareLogRecord = (BaseEntryType)obj;
        
        if (this.logRecord.Date__c > compareLogRecord.logRecord.Date__c
            || (this.logRecord.Date__c == compareLogRecord.logRecord.Date__c
            && this.logRecord.Duration__c > compareLogRecord.logRecord.Duration__c)
        ) {
            return 1;
        } else if (this.logRecord.Duration__c == compareLogRecord.logRecord.Duration__c
        && this.logRecord.Date__c == compareLogRecord.logRecord.Date__c
        ) {
            return 0;
        }
        
        return -1;
    }
    public Time_Log__c getRecord() {
        return this.logRecord;
    }
}