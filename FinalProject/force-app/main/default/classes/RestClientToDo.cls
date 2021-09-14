public with sharing class RestClientToDo {

    private static final String SOBJECTURL = 'ToDo__c/';

    @future(callout=true)
    public static void sendCreateToDoRequest(List<Id> ids) {
        List<ToDo__c> toDos = ToDoSoql.getToDosById(ids);
        
        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
        String jsonBody = JSON.serialize(wrappers);

        HttpResponse response = RestClient.sendRequest(jsonBody, 'POST', SOBJECTURL);
        toDos = RestClientToDoHelper.parcingResponce(toDos, response);

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update toDos;
    }

    @future(callout=true)
    public static void sendDeleteToDoRequest(List<Id> extertalIds) {
        
        String jsonBody = JSON.serialize(extertalIds);
        HttpResponse response = RestClient.sendRequest(jsonBody, 'DELETE', SOBJECTURL);
    } 
    
    @future(callout=true)
    public static void sendUpdateToDoRequest(List<Id> ids) {

        List<ToDo__c> toDos = ToDoSoql.getToDosById(ids);

        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
        String jsonBody = JSON.serialize(wrappers);
       
        HttpResponse response = RestClient.sendRequest(jsonBody, 'PATCH', SOBJECTURL);
        toDos = RestClientToDoHelper.parcingResponce(toDos, response);

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update toDos;
    }  
    
}