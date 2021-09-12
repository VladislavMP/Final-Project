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

  // select Id,Name from RecordType where sObjectType='Todo__c'
  // Select Id, Name, RecordType.Name, RecordType.Id  from Todo__c
  // SELECT Id, Name, RecordType.Name, RecordType.Id, (select Id, Name from Sub_ToDos__r) FROM Todo__c 
}