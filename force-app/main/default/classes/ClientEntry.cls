public class ClientEntry extends BaseEntryType {
    
    public ClientEntry(Time_log__c logRecord, Decimal hourlyRate) {
        super(logRecord, hourlyRate);
    }
    
    public override String getEntryCategory() {
        return 'Billable';
    }
    
    public override Decimal calculateTotalCost() {
        return super.calculateTotalCost() * 1.1;
    }
}