public with sharing class TodoQuery {

  @AuraEnabled(cacheable=true)
  public static  List<ToDo__c> getTodoList() {
      return [SELECT Id, 
              Name, 
              RecordType.DeveloperName, 
              RecordType.Id, 
              (select Id, Name, Data__c, CreatedDate, Is_done__c from Sub_ToDos__r) 
              FROM ToDo__c ];
  }
}
