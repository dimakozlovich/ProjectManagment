public class TimeLogManager {
    public Map<Id, List<Time_Log__c>> groupByProject(List<Time_Log__c> logs) {
        Map<Id, List<Time_Log__c>> groupedLogs = new Map<Id, List<Time_Log__c>>();
        
        for (Time_Log__c log : logs) {
            if (log.Project_Assignment__r?.Project__c == null) {
                throw new IllegalArgumentException('Exception: field Project_Assignment__r is not loaded');
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
    public List<Time_Log__c> searchLogs(Map<String, Object> filters) {
        String query = 'SELECT Id, Name, Project__c, User__c, Date__c, Description__c ' +
            'FROM Time_Log__c';
        
        List<String> conditions = new List<String>();
        
        
        for (String key : filters.keySet()) {
            Object value = filters.get(key);
            
            switch on key {
                when 'ProjectId' {
                    String projectId = String.escapeSingleQuotes(String.valueOf(value));
                    conditions.add('Project__c = \'' + projectId + '\'');
                }
                when 'UserId' {
                    String userId = String.escapeSingleQuotes(String.valueOf(value));
                    conditions.add('User__c = \'' + userId + '\'');
                }
                when 'StartDate' {
                    Date startDate = (Date) value;
                    conditions.add('Date__c >= ' + String.valueOf(startDate));
                }
                when 'EndDate' {
                    Date endDate = (Date) value;
                    conditions.add('Date__c <= ' + String.valueOf(endDate));
                }
            }
        }
        query += ' WHERE ' + String.join(conditions, ' AND ');
        return Database.query(query);
    }
}