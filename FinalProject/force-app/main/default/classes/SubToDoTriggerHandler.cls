public with sharing class SubToDoTriggerHandler{
    public static Boolean disableIntegrationInTriggerFlag = false;

    public static void handleBeforeInsert(List<Sub_ToDo__c> newList){

    } 

    public static void handleBeforeUpdate(List<Sub_ToDo__c> newList, Map<Id, Sub_ToDo__c> newMap, List<Sub_ToDo__c> oldList, Map<Id, Sub_ToDo__c> oldMap){

    } 

    public static void handleBeforeDelete(List<Sub_ToDo__c> oldList, Map<Id, Sub_ToDo__c> oldMap){

    } 

    public static void handleAfterInsert(List<Sub_ToDo__c> newList, Map<Id, Sub_ToDo__c> newMap){
        if(!disableIntegrationInTriggerFlag){
            List<Id> subToDoIds = SubToDoTriggerHelper.getIdList(newList);
            RestClientSubToDo.sendCreateSubToDoRequest(subToDoIds);
        } else {
            disableIntegrationInTriggerFlag = false;
        }
    } 

    public static void handleAfterUpdate(List<Sub_ToDo__c> newList, Map<Id, Sub_ToDo__c> newMap, List<Sub_ToDo__c> oldList, Map<Id, Sub_ToDo__c> oldMap){
        if(!disableIntegrationInTriggerFlag){
            List<Id> subToDoIds = SubToDoTriggerHelper.getIdList(newList);
            RestClientSubToDo.sendUpdateSubToDoRequest(subToDoIds);
        } else {
            disableIntegrationInTriggerFlag = false;
        }
    } 

    public static void handleAfterDelete(List<Sub_ToDo__c> oldList, Map<Id, Sub_ToDo__c> oldMap){
        if(!disableIntegrationInTriggerFlag){
            List<Id> subToDoIds = SubToDoTriggerHelper.getExternalIdList(oldList);
            RestClientSubToDo.sendDeleteSubToDoRequest(subToDoIds);
        } else {
            disableIntegrationInTriggerFlag = false;
        }
    } 

    public static void handleAfterUndelete(List<Sub_ToDo__c> newList, Map<Id, Sub_ToDo__c> newMap){
        
    } 
}