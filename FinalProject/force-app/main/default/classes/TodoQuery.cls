public with sharing class TodoQuery {

  @AuraEnabled(cacheable=true)
  public static List<ToDo__c> getTodoList() {
      return [
        SELECT Id, 
        Name, 
        RecordType.DeveloperName, 
        RecordType.Id, 
        Owner.Type,
        (select Id, Name, CreatedDate, Status__c from Sub_ToDos__r) 
        FROM ToDo__c 
      ];
  }
}
