public with sharing class RestClientSubToDoMock implements HttpCalloutMock {

    public String responseBody;
    public RestClientSubToDoMock(String responseBody) {
        this.responseBody = responseBody;
    }

    private RestClientSubToDoMock() {
    }


    public HttpResponse respond(HttpRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        response.setBody(responseBody);
        return response;
	}
}