public with sharing class ToDoSoql {

    public static List<ToDo__c> getToDosById(List<Id> ids){
        return new List<ToDo__c>([
            SELECT Id, Name, RecordTypeId, External_Id__c, Status__c
            FROM ToDo__c 
            WHERE Id =: ids
        ]);
    }
}
