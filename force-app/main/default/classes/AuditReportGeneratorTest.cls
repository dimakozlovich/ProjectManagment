@IsTest
public class AuditReportGeneratorTest {
    
    @IsTest
    static void testAuditReportGeneratorExecution() {
        Integer expectedRejectedLogs = 12;
        Decimal expectedRejectedHours = 24.5;
        
        AuditReportGenerator reportJob = new AuditReportGenerator(expectedRejectedLogs, expectedRejectedHours);
        
        Test.startTest();
        Id jobId = System.enqueueJob(reportJob);
        Test.stopTest();
        
        System.assertNotEquals(null, jobId, 'The Queueable job should have returned a valid Job ID.');
        
        AsyncApexJob jobInfo = [
            SELECT Id, Status, JobType 
            FROM AsyncApexJob 
            WHERE Id = :jobId
        ];
        
        System.assertEquals('Queueable', jobInfo.JobType, 'The job type should be Queueable.');
        System.assertEquals('Completed', jobInfo.Status, 'The job should have completed without errors.');
    }
}