public class InternalEntry extends BaseEntryType {
    public InternalEntry(Time_Log__c logRecord, Decimal hourlyRate) {
        super(logRecord, hourlyRate);
    }
    
    protected override String getEntryCategory() {
        return 'Non-Billable';
    }
    
    protected override Decimal calculateTotalCost() {
        return 0;
    }
}