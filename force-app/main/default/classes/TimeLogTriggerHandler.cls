public class TimeLogTriggerHandler {
    public static boolean isFirstRun = true;

    public void avoidLegacyProjects(List<Time_Log__c> newLogs) {
        Set<Id> projectAssignmentsId = new Set<Id>();
        for (Time_Log__c log : newLogs) {
            if (log.Project_Assignment__c != null) {
                projectAssignmentsId.add(log.Project_Assignment__c);
            }
        }

        Map<Id, Project_Assignment__c> assignmentsMap = new Map<Id, Project_Assignment__c>([
            SELECT Project__r.Status__c
            FROM Project_Assignment__c
            WHERE Id IN :projectAssignmentsId
        ]);

        for (Time_Log__c log : newLogs) {
            Project_Assignment__c assignment = assignmentsMap.get(log.Project_Assignment__c);
            String status = assignment?.Project__r?.Status__c;
            if (status == 'Archived' || status == 'Closed') {
                log.addError('Project is Archived or Closed.');
            }
        }
    }
    public void setInHighPriorityLogs(List<Time_Log__c> logs) {
        for (Time_Log__c log : logs) {
            log.Is_High_Priority__c = String.isNotBlank(log.Description__c) 
                                      && log.Description__c.containsIgnoreCase('[URGENT]');
        }
    }
}