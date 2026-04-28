public with sharing class TimeLogManager {
    public Map<Id, List<Time_Log__c>> groupByProject(List<Time_Log__c> logs) {
        Map<Id, List<Time_Log__c>> groupedLogs = new Map<Id, List<Time_Log__c>>();

        for (Time_Log__c log : logs) {
            if (log.Project_Assignment__r.Project__c == null) {
                throw new IllegalArgumentException(
                    'Exception: field Project_Assignment__r is not loaded'
                );
            }

            Id projectId = log.Project_Assignment__r.Project__c;

            if (groupedLogs.containsKey(projectId)) {
                groupedLogs.get(projectId).add(log);
            } else {
                List<Time_Log__c> projectLogs = new List<Time_Log__c>();
                projectLogs.add(log);
                groupedLogs.put(projectId, projectLogs);
            }
        }
        return groupedLogs;
    }

    public void processRecords(List<sObject> records) {
        for (sObject record : records) {
            if (record instanceof Project__c) {
                System.Debug(((Project__c) record).Name);
            } else if (record instanceof Time_Log__c) {
                System.Debug(((Time_Log__c) record).Name);
            }
        }
    }
}
