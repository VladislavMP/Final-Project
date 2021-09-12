public with sharing class RestClientSubToDoHelper {
    
    private static final String ENDPOINT = 'callout:RestApi/services/apexrest/Sub_ToDo__c/';
    private static final String HEADER_CONTENT_TYPE = 'Content-Type';
    private static final String HEADER_JSON_CONTENT_TYPE = 'application/json';
    
    public static HttpRequest createRequest(List<Sub_ToDo__c> subToDos, String method){
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod(method);
        request.setBody(JSON.serialize(subToDos));
        return request;
    }
    
    public static HttpRequest createRequest(List<String> ids, String method){
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod(method);
        request.setBody(JSON.serialize(ids));
        return request;
    }

    public static List<Sub_ToDo__c> createRecordsForRequest(List<Sub_ToDo__c> subToDos){
        List<Sub_ToDo__c> newSubToDos = new List<Sub_ToDo__c>();
        for (Sub_ToDo__c subToDo : subToDos){
            newSubToDos.add(new Sub_ToDo__c(
                Id = subToDo.Id,
                ToDo__c = subToDo.ToDo__r.External_Id__c,
                Name = subToDo.Name,
                External_Id__c = subToDo.External_Id__c,
                Status__c = subToDo.Status__c
            ));
        }

        return  newSubToDos;
    }
}