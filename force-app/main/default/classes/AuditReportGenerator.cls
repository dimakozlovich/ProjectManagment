public class AuditReportGenerator implements Queueable {
    
    private Integer totalRejectedLogs;
    private Decimal totalRejectedHours;
    
    public AuditReportGenerator(Integer rejectedLogsCount, Decimal rejectedHours) {
        this.totalRejectedLogs = rejectedLogsCount;
        this.totalRejectedHours = rejectedHours;
    }
    
    public void execute(QueueableContext context) {
        System.debug('- Total logs rejected (under 5 words): ' + this.totalRejectedLogs);
        System.debug('- Total hours rejected: ' + this.totalRejectedHours);
    }
}