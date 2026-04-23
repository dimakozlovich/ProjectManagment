public with sharing class ProjectSummary {
    
    public String projectName {get; private set;}
    public Decimal totalHours {get; private set;}
    public Boolean isOverBudget {get; private set;}
    
    public ProjectSummary(Project__c project) {
        this.projectName = project.Name;
        this.totalHours = countTotalHours(project);
        this.isOverBudget = TimeTrackerUtil.isOvertime(this.totalHours);
    }


    private decimal countTotalHours(Project__c project){
        List<Time_Log__c> logs = [SELECT Id, Duration__c, Project_Assignment__r.Project__c 
                                  FROM Time_Log__c Where Project_Assignment__r.Project__c =:project.Id];

        decimal total = 0;
        for(Time_Log__c log : logs){
            total += log.Duration__c;
        }
        return total;
    }
}