public with sharing class ProjectSummary {
  public String projectName { get; private set; }
  public Decimal totalHours { get; private set; }
  public Boolean isOverBudget { get; private set; }
  
  public ProjectSummary(Project__c project) {
    
    if(project == null){
      throw new IllegalArgumentException('Project__c cannot be null');
    }
    this.projectName = project.Name;
    this.totalHours = project.Total_Logged_Hours__c != null ? project.Total_Logged_Hours__c : 0;
    this.isOverBudget = TimeTrackerUtil.isOvertime(this.totalHours);
  }
}