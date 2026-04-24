@isTest
public class TimeLogManagerTest {
    @TestSetup
    static void setupTestData()
    {
        List<Project__c> projects = new List<Project__c>();
        projects.add(new Project__c(Name = 'Project 1', Status__c = 'In Progress'));
        projects.add(new Project__c(Name = 'Project 1', Status__c = 'In Progress'));
        insert projects;


        List<Project_Assignment__c> assignments = new List<Project_Assignment__c>();
        assignments.add(new Project_Assignment__c(Project__c = projects[0].Id, User__c = UserInfo.getUserId())); 
        assignments.add(new Project_Assignment__c(Project__c = projects[1].Id, User__c = UserInfo.getUserId())); 
        insert assignments;
        
        List<Time_Log__c> timeLogs = new List<Time_Log__c>();
        
        timeLogs.add(new Time_Log__c(
            Name = 'feature: make some changes on main page', 
            Project_Assignment__c = assignments[0].Id
        ));
        timeLogs.add(new Time_Log__c(
            Name = 'bug: fixed syntax bug in TimeLogManager class', 
            Project_Assignment__c = assignments[0].Id
        ));
        timeLogs.add(new Time_Log__c(
            Name = 'feature: add new button', 
            Project_Assignment__c = assignments[1].Id
        ));
        
        insert timeLogs;
    }

    @isTest
    static void groupByProject(){
        List<Time_Log__c> logs = [SELECT Id, Duration__c, Project_Assignment__r.Project__c FROM Time_Log__c];

        TimeLogManager timeLogManager = new TimeLogManager();
        Map<Id,List<Time_Log__c>> groupedLogs = timeLogManager.groupByProject(logs);
        System.assert(groupedLogs.size() == 2);

        List<Time_Log__c> projectLogs = groupedLogs.get(logs[0].Id);
        System.assert(logs.size()>0);

    }
}