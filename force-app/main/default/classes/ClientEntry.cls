public class ClientEntry extends BaseEntryType {
    private static final Decimal SERVICE_FEE_MULTIPLIER = 1.1;
    
    public ClientEntry(Time_Log__c logRecord, Decimal hourlyRate) {
        super(logRecord, hourlyRate);
    }
    
    protected override String getEntryCategory() {
        return 'Billable';
    }
    
    protected override Decimal calculateTotalCost() {
        return super.calculateTotalCost() * SERVICE_FEE_MULTIPLIER;
    }
}