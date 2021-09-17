public with sharing class ToDoHelper {
    public static List<Id> getIdList(List<ToDo__c> toDoList) {
        List<Id> toDoIdList = new List<Id>();
        for(ToDo__c toDo : toDoList) {
            toDoIdList.add(toDo.Id);
        }
        
        return toDoIdList;
    }

    public static List<Id> getExternalIdList(List<ToDo__c> toDoList) {
        List<Id> toDoIdList = new List<Id>();
        for(ToDo__c toDo : toDoList) {
            toDoIdList.add(toDo.External_Id__c);
        }
        
        return toDoIdList;
    }
}