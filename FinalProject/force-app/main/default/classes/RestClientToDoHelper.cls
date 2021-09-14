public with sharing class RestClientToDoHelper {

    public static List<ToDoWrapper> wrapToDos(List<ToDo__c> toDos){
        List<ToDoWrapper> wrappers = new List<ToDoWrapper>();
        for(ToDo__c todo : toDos){
        	String recordTypeName = Schema.SObjectType.ToDo__c
                .getRecordTypeInfosById().get(toDo.RecordTypeId).getName();
        	wrappers.add(new ToDoWrapper(toDo, recordTypeName));
        }
        return wrappers;
    }

    public static List<ToDo__c> parcingResponce(List<ToDo__c> toDos, HttpResponse response){
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(ToDo__c todo : toDos){
            toDo.External_Id__c = externalIdsMap.get(toDo.Id);
        }

        return toDos;
    }
}
