public with sharing class RestClientSubToDo {

    private static final String SOBJECTURL = 'Sub_ToDo__c/';

    @future(callout=true)
    public static void sendCreateSubToDoRequest(List<Id> ids) {
        List<Sub_ToDo__c> subToDos = SubToDoSoql.getSubToDosById(ids);

        List<Sub_ToDo__c> newSubToDos = RestClientSubToDoHelper.createRecordsForRequest(subToDos);
        String jsonBody = JSON.serialize(newSubToDos);

        HttpResponse response = RestClient.sendRequest(jsonBody, 'POST', SOBJECTURL);
        subToDos = RestClientSubToDoHelper.parcingResponce(subToDos, response);

        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update subToDos;
    }

    @future(callout=true)
    public static void sendDeleteSubToDoRequest(List<Id> extertalIds) {
        
        String jsonBody = JSON.serialize(extertalIds);
        HttpResponse response = RestClient.sendRequest(jsonBody, 'DELETE', SOBJECTURL);
    } 
    
    @future(callout=true)
    public static void sendUpdateSubToDoRequest(List<Id> ids) {
        List<Sub_ToDo__c> subToDos = SubToDoSoql.getSubToDosById(ids);

        List<Sub_ToDo__c> newSubToDos = RestClientSubToDoHelper.createRecordsForRequest(subToDos);
        String jsonBody = JSON.serialize(newSubToDos);

        HttpResponse response = RestClient.sendRequest(jsonBody, 'PATCH', SOBJECTURL);
        subToDos = RestClientSubToDoHelper.parcingResponce(subToDos, response);

        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update subToDos;
    }  
    
}