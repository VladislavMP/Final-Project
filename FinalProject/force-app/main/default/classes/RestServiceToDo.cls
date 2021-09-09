@RestResource(urlMapping='/ToDo__c/*')
global with sharing class RestServiceToDo {

    @HttpPost
    global static Map<String, String> createRecord(){
        RestRequest request = RestContext.request;
		List<ToDoWrapper> wrappers = (List<ToDoWrapper>) 
            JSON.deserialize(request.requestBody.toString(), List<ToDoWrapper>.class);
        List<ToDo__c> toDos = RestServiceToDoHelper.unwrapToDos(wrappers, true);

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert toDos;
        
        Map<String, String> toDosIdsMap = RestServiceToDoHelper.getToDosIdsMap(toDos);
        return toDosIdsMap;
    }

    @HttpDelete
    global static void deleteRecord(){
        RestRequest request = RestContext.request;
        List<String> toDosIds = (List<String>) 
            JSON.deserialize(request.requestBody.toString(), List<String>.class);
        
        List<ToDo__c> toDos = [SELECT Id 
            FROM ToDo__c 
            WHERE Id = :toDosIds
        ];
        
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        delete toDos;
    }

    @HttpPatch
    global static Map<String, String> updateRecord(){
        RestRequest request = RestContext.request;
		List<ToDoWrapper> wrappers = (List<ToDoWrapper>) 
            JSON.deserialize(request.requestBody.toString(), List<ToDoWrapper>.class);
        List<ToDo__c> toDos = RestServiceToDoHelper.unwrapToDos(wrappers, false);

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update toDos;
        
        Map<String, String> toDosIdsMap = RestServiceToDoHelper.getToDosIdsMap(toDos);
        return toDosIdsMap;
    }
}