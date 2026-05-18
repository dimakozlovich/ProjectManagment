public interface LogProcessorInterface {
    List<Time_Log__c> processData(List<BaseEntryType> records, String operationType);
    void syncWithDatabase(List<BaseEntryType> records, String operationType);
}