public with sharing class ToDoTriggerHandler {
    public static Boolean disableIntegrationInTriggerFlag = false;

    public static void handleBeforeInsert(List<ToDo__c> todos){
        if(!disableIntegrationInTriggerFlag){
		    QueueTriggerHandlerHelper.assignmentQueue(todos);
        }
    } 

    public static void handleBeforeUpdate(List<ToDo__c> newList, Map<Id, ToDo__c> newMap, List<ToDo__c> oldList, Map<Id, ToDo__c> oldMap){

    } 

    public static void handleBeforeDelete(List<ToDo__c> oldList, Map<Id, ToDo__c> oldMap){

    } 

    public static void handleAfterInsert(List<ToDo__c> newList, Map<Id, ToDo__c> newMap){
        if(!disableIntegrationInTriggerFlag){
            List<Id> toDoIds = ToDoHelper.getIdList(newList);
            RestClientToDo.sendCreateToDoRequest(toDoIds);
        } else {
            disableIntegrationInTriggerFlag = false;
        }
    } 

    public static void handleAfterUpdate(List<ToDo__c> newList, Map<Id, ToDo__c> newMap, List<ToDo__c> oldList, Map<Id, ToDo__c> oldMap){
        if(!disableIntegrationInTriggerFlag){
            List<Id> toDoIds = ToDoHelper.getIdList(newList);
            RestClientToDo.sendUpdateToDoRequest(toDoIds);
        } else {
            disableIntegrationInTriggerFlag = false;
        }
    } 

    public static void handleAfterDelete(List<ToDo__c> oldList, Map<Id, ToDo__c> oldMap){
        if(!disableIntegrationInTriggerFlag){
            List<Id> toDoIds = ToDoHelper.getExternalIdList(oldList);
            RestClientToDo.sendDeleteToDoRequest(toDoIds);
        } else {
            disableIntegrationInTriggerFlag = false;
        }
    } 

    public static void handleAfterUndelete(List<ToDo__c> newList, Map<Id, ToDo__c> newMap){
        
    } 
}