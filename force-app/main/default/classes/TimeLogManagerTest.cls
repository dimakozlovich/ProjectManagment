@isTest
public class TimeLogManagerTest {
  @TestSetup
  static void setupTestData() {
    List<Project__c> projects = new List<Project__c>();
    projects.add(new Project__c(Name = 'Project 1', Status__c = 'In Progress'));
    projects.add(new Project__c(Name = 'Project 1', Status__c = 'In Progress'));
    insert projects;
    
    List<Project_Assignment__c> assignments = new List<Project_Assignment__c>();
    assignments.add(
      new Project_Assignment__c(
      Project__c = projects[0].Id,
    User__c = UserInfo.getUserId()
      )
      );
    assignments.add(
      new Project_Assignment__c(
      Project__c = projects[1].Id,
    User__c = UserInfo.getUserId()
      )
      );
    insert assignments;
    
    List<Time_Log__c> timeLogs = new List<Time_Log__c>();
    
    timeLogs.add(
      new Time_Log__c(
      Name = 'feature: make some changes on main page',
    Project_Assignment__c = assignments[0].Id
      )
      );
    timeLogs.add(
      new Time_Log__c(
      Name = 'bug: fixed syntax bug in TimeLogManager class',
    Project_Assignment__c = assignments[0].Id
      )
      );
    timeLogs.add(
      new Time_Log__c(
      Name = 'feature: add new button',
    Project_Assignment__c = assignments[1].Id
      )
      );
    
    insert timeLogs;
  }
  
  @isTest
  static void groupByProject() {
    List<Time_Log__c> logs = [
      SELECT Id, Duration__c, Project_Assignment__r.Project__c
      FROM Time_Log__c
    ];
    
    TimeLogManager timeLogManager = new TimeLogManager();
    Map<Id, List<Time_Log__c>> groupedLogs = timeLogManager.groupByProject(
      logs
      );
    
    Map<Id, Integer> expectedCountsByProject = new Map<Id, Integer>();
    
    for (Time_Log__c log : logs) {
      Id projectId = log.Project_Assignment__r.Project__c;
      expectedCountsByProject.put(
        projectId,
      expectedCountsByProject.containsKey(projectId)
        ? expectedCountsByProject.get(projectId) + 1
        : 1
        );
    }
    
    System.assertEquals(2, groupedLogs.size());
    System.assertEquals(expectedCountsByProject.size(), groupedLogs.size());
    
    for (Id projectId : expectedCountsByProject.keySet()) {
      List<Time_Log__c> projectLogs = groupedLogs.get(projectId);
      System.assertNotEquals(null, projectLogs);
      System.assertEquals(
        expectedCountsByProject.get(projectId),
      projectLogs.size()
        );
      for (Time_Log__c projectLog : projectLogs) {
        System.assertEquals(
          projectId,
        projectLog.Project_Assignment__r.Project__c
          );
      }
    }
  }
}