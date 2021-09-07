public with sharing class RestClientToDoMock implements HttpCalloutMock {

    public static String id;
    
    public HttpResponse respond(HttpRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        System.debug(request.getMethod());
        if (request.getMethod().equals('GET')) {
        } else if (request.getMethod().equals('POST')) {
            response.setBody(JSON.serialize(new Map<String, String>{id => '0012w00000L74CqAAJ'}));
        } else if (request.getMethod().equals('DELETE')) {
        } else if (request.getMethod().equals('PUT')) {
            response.setBody(JSON.serialize(new Map<String, String>{id => '0012w00000L74CqAAJ'}));
        } else if (request.getMethod().equals('PATCH')) {
            response.setBody(JSON.serialize(new Map<String, String>{id => '0012w00000L74CqAAJ'}));
        }
        return response;
	}
}