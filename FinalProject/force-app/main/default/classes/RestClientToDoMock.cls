public with sharing class RestClientToDoMock implements HttpCalloutMock {

    public String responseBody;
    public RestClientToDoMock(String responseBody) {
        this.responseBody = responseBody;
    }

    private RestClientToDoMock() {
    }


    public HttpResponse respond(HttpRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        response.setBody(responseBody);
        return response;
	}
}