@IsTest
private with sharing class RestClientSubToDoTest {
    
    @IsTest
    static void createSubToDoTest() {
        Sub_ToDo__c subToDo = RestClientSubToDoTest.createTestSubToDo('TestName', 'a005g0000305ICGAA2', true);
        List<Id> subToDoIds = new List<Id>{subToDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{subToDo.Id => '0012w00000L74CqAAJ'});

        Test.setMock(HttpCalloutMock.class, new RestClientSubToDoMock(responceBody));            
		Test.startTest();
        RestClientSubToDo.createSubToDo(subToDoIds);
        Test.stopTest();

        subToDo = [SELECT External_Id__c FROM Sub_ToDo__c WHERE Id =: subToDo.Id];
        Id externalId = subToDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }
    
    @IsTest
    static void deleteSubToDoTest() {
        Sub_ToDo__c subToDo = RestClientSubToDoTest.createTestSubToDo('TestName', 'a005g0000305ICGAA2', true);
        List<Id> subToDoIds = new List<Id>{subToDo.Id};
        Boolean testTry = true;
        String responceBody = JSON.serialize(new Map<String, String>{subToDo.Id => '0012w00000L74CqAAJ'});

        Test.setMock(HttpCalloutMock.class, new RestClientSubToDoMock(responceBody));            
		Test.startTest();
        try{
            RestClientSubToDo.deleteSubToDo(subToDoIds);
        }
        catch(Exception e){
            testTry = false;
        }
        Test.stopTest();

        System.assertEquals(true, testTry);
    }
    
    @IsTest
    static void updateSubToDoTest() {
        Sub_ToDo__c subToDo = RestClientSubToDoTest.createTestSubToDo('TestName', 'a005g0000305ICGAA2', true);
        List<Id> subToDoIds = new List<Id>{subToDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{subToDo.Id => '0012w00000L74CqAAJ'});

        Test.setMock(HttpCalloutMock.class, new RestClientSubToDoMock(responceBody));            
		Test.startTest();
        RestClientSubToDo.updateSubToDo(subToDoIds);
        Test.stopTest();

        subToDo = [SELECT Id, External_Id__c FROM Sub_ToDo__c WHERE Id =: subToDo.Id];
        Id externalId = subToDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }

    static Sub_ToDo__c createTestSubToDo(String name, Id toDoId, Boolean needInsert){
        Sub_ToDo__c subToDo = new Sub_ToDo__c(Name = name, ToDo__c = toDoId);
        If (needInsert) insert subToDo;
        return subToDo;
    }
}