public class ClientEntry extends BaseEntryType {
    
    private static final Decimal SERVICE_FEE_MULTIPLIER = 1.1;
    
    public ClientEntry(Time_Log__c logRecord, Decimal hourlyRate) {
        super(logRecord, hourlyRate);
    }
    
    public override String getEntryCategory() {
        return 'Billable';
    }
    
    public override Decimal calculateTotalCost() {
        return super.calculateTotalCost() * SERVICE_FEE_MULTIPLIER;
    }
}