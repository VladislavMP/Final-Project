@IsTest
private with sharing class RestClientToDoTest {
    
    @IsTest
    static void sendCreateToDoRequestTest() {
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        List<Id> toDoIds = new List<Id>{toDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{toDo.Id => '0012w00000L74CqAAJ'});

        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody));            
		Test.startTest();
        RestClientToDo.sendCreateToDoRequest(toDoIds);
        Test.stopTest();

        toDo = [SELECT External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }
    
    @IsTest
    static void sendDeleteToDoRequestTest() {
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        List<Id> toDoIds = new List<Id>{toDo.Id};
        Boolean testTry = true;
        String responceBody = JSON.serialize(new Map<String, String>{toDo.Id => '0012w00000L74CqAAJ'});
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody)); 
        Test.startTest();
        try{
            RestClientToDo.sendDeleteToDoRequest(toDoIds);
        }
        catch(Exception e){
            testTry = false;
        }
        Test.stopTest();
        System.assertEquals(true, testTry);
    }
    
    @IsTest
    static void sendUpdateToDoRequestTest() {
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        List<Id> toDoIds = new List<Id>{toDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{toDo.Id => '0012w00000L74CqAAJ'});

        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody)); 
		Test.startTest();
        RestClientToDo.sendUpdateToDoRequest(toDoIds);
        Test.stopTest();

        toDo = [SELECT Id, External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }

    static ToDo__c createTestToDo(String name, Boolean needInsert){
        ToDo__c toDo = new ToDo__c(Name = name);
        If (needInsert) {
            ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
            insert toDo;
        }
        return toDo;
    }
}