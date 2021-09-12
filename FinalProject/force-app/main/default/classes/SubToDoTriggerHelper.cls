public with sharing class SubToDoTriggerHelper {

    public static List<Id> getIdList(List<Sub_ToDo__c> subToDoList){
        List<Id> subToDoIdList = new List<Id>();
        for(Sub_ToDo__c subToDo : subToDoList){
            subToDoIdList.add(subToDo.Id);
        }
        
        return subToDoIdList;
    }

    public static List<Id> getExternalIdList(List<Sub_ToDo__c> subToDoList){
        List<Id> subToDoIdList = new List<Id>();
        for(Sub_ToDo__c subToDo : subToDoList){
            subToDoIdList.add(subToDo.External_Id__c);
        }
        
        return subToDoIdList;
    }
}