public with sharing class TimeLogManager {

    public Map<Id,List<Time_Log__c>> groupByProject(List<Time_Log__c> logs){

        Map<Id,List<Time_log__c>> groupedLogs = new Map<Id,List<Time_log__c>>();

        for(Time_Log__c log : logs){


            Id projectId = log.Project_Assignment__c;

            if(groupedLogs.containsKey(projectId))
            {
                groupedLogs.get(projectId).add(log);
            }
            else {
                List<Time_log__c> projectLogs = new List<Time_log__c>();
                projectLogs.add(log);
                groupedLogs.put(projectId,projectLogs);
            }

        }
        return groupedLogs;
    }
}