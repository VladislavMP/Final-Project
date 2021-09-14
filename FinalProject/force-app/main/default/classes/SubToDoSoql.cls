public with sharing class SubToDoSoql {

    public static List<Sub_ToDo__c> getSubToDosById(List<Id> ids){
        return new List<Sub_ToDo__c>([
            SELECT Id, Name, External_Id__c, ToDo__c, ToDo__r.External_Id__c, Status__c
            FROM Sub_ToDo__c 
            WHERE Id =: ids
        ]);
    }
}
