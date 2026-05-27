public interface LogProcessorInterface {
    List<Time_Log__c> processData(String operationType);
    void syncWithDatabase(String operationType);
}