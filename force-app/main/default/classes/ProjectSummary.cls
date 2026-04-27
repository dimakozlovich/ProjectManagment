public with sharing class ProjectSummary {
  public String projectName { get; private set; }
  public Decimal totalHours { get; private set; }
  public Boolean isOverBudget { get; private set; }
  
  public ProjectSummary(Project__c project) {
    this.projectName = project.Name;
    this.totalHours = project.Total_Logged_Hours__c;
    this.isOverBudget = TimeTrackerUtil.isOvertime(this.totalHours);
  }
  
}