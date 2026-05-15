public class InternalEntry extends BaseEntryType {
    public InternalEntry(Time_Log__c logRecord, Decimal hourlyRate) {
        super(logRecord, hourlyRate);
    }
    
    public override String getEntryCategory() {
        return 'Non-Billable';
    }
    
    public override Decimal calculateTotalCost() {
        return 0;
    }
}