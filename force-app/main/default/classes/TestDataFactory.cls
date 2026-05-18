@isTest
public class TestDataFactory {

    public static void createLogsRecords(Integer quantity) {
        List<Project__c> projects = new List<Project__c>();
        Set<String> statuses = new Set<String>{'Not Started', 'In Progress', 'Completed'};

        for (String status : statuses) {
            projects.add(new Project__c(Name = status + ' 1', Status__c = status));
            projects.add(new Project__c(Name = status + ' 2', Status__c = status));
        }
        insert projects;

        List<Project_Assignment__c> assignments = new List<Project_Assignment__c>();

        for (Project__c project : projects) {
            assignments.add(new Project_Assignment__c(
                Project__c = project.Id,
                User__c = UserInfo.getUserId()
            ));
        }
        insert assignments;

        List<Time_Log__c> logs = new List<Time_Log__c>();

        if (!assignments.isEmpty()) {
            for (Integer i = 1; i < quantity; i++) {
                Integer assignmentIndex = Math.mod(i, assignments.size());
                logs.add(new Time_Log__c(
                    Name = 'logname____________' + i,
                    Project_Assignment__c = assignments.get(assignmentIndex).Id,
                    Duration__c = Math.mod(i, 12) + 1,
                    Status__c = 'Submitted',
                    Date__c = Date.today(),
                    Description__c = Math.mod(i, 2) == 0 ? 'log with correct description size' : 'incorrect description'
                ));
            }
        }

        insert logs;
    }
}