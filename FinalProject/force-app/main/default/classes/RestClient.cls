public with sharing class RestClient {
    
    private static final String HEADER_CONTENT_TYPE = 'Content-Type';
    private static final String HEADER_JSON_CONTENT_TYPE = 'application/json';
    private static final String ENDPOINT = 'callout:RestApi/services/apexrest/';

    public static HttpResponse sendRequest(String jsonBody, String method, String sObjectUrl){
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT + sObjectUrl);
        request.setMethod(method);
        request.setBody(jsonBody);
        Http httpConnection = new Http();
        HttpResponse response = httpConnection.send(request);
        
        return response;
    }
}
