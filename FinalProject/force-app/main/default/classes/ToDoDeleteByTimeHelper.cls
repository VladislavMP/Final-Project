public with sharing class ToDoDeleteByTimeHelper {
    private static final String ENDPOINT = 'callout:RestApi/services/apexrest/ToDo__c/';
    private static final String HEADER_CONTENT_TYPE = 'Content-Type';
    private static final String HEADER_JSON_CONTENT_TYPE = 'application/json';
    
    public static HttpRequest createRequest(List<String> ids, String method){
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod(method);
        request.setBody(JSON.serialize(ids));
        return request;
    }


}
