@isTest
public class ProjectSummaryTest {
    @TestSetup
    static void setupTestData()
    {

        Project__c project = new Project__c(Name = 'Project 1', Status__c = 'In Progress');
        insert project;

        Project_Assignment__c projectAssignment = new Project_Assignment__c(Project__c = project.Id, User__c = UserInfo.getUserId()); 
        insert projectAssignment;
        
        List<Time_Log__c> timeLogs = new List<Time_Log__c>();
        
        timeLogs.add(new Time_Log__c(
            Name = 'feature: make some changes on main page', 
            Project_Assignment__c = projectAssignment.Id,
            Duration__c = 4
        ));
        timeLogs.add(new Time_Log__c(
            Name = 'bug: fixed syntax bug in TimeLogManager class', 
            Project_Assignment__c = projectAssignment.Id,
            Duration__c = 2
        ));
        timeLogs.add(new Time_Log__c(
            Name = 'feature: add new button', 
            Project_Assignment__c = projectAssignment.Id,
            Duration__c = 7
        ));
        
        insert timeLogs;
    }
    @isTest
    static void projectSummaryConstructorTest()
    {
        List<Project__c> project = [SELECT Id, Name From Project__c Limit 1];
        ProjectSummary projectSummary = new ProjectSummary(project[0]);

        System.assertEquals('Project 1', projectSummary.projectName);
    }
}