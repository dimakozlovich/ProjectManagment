trigger TimeLogTrigger on Time_Log__c (before insert, before update) {
    TimeLogTriggerHandler handler = new TimeLogTriggerHandler();
    
    if (Trigger.isBefore) {
        if (TimeLogTriggerHandler.isFirstRun) {
            TimeLogTriggerHandler.isFirstRun = false;
            
            handler.avoidLegacyProjects(Trigger.new);
            if (Trigger.isInsert) {
                handler.setInHighPriorityLogs(Trigger.new);
            }
        }
    }
}