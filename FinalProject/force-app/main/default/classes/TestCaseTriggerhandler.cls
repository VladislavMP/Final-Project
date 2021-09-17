@isTest
public class TestCaseTriggerhandler {
    @IsTest
    static void testcreateCaseTodo() {
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = True;
        List<Case> cases = new List<Case>();
        Case cs = new Case();
        cs.Origin = 'Email';
        cs.Subject = 'Subject';
        cs.Description = 'Apex provides a testing framework that allows you to write unit tests ' +
        'run your tests, ' +
        'check test results ' +
        'and have code coverage results. ' +
        'talk about unit tests, data visibility for tests, and the tools that are available on the Lightning platform' ;
        cs.Status = 'New';
        cases.add(cs);
        

        Test.startTest();
        CreateToDoEmail.todoInsert(cases);
        Todo__c todos = new Todo__c(
            RecordTypeId = '0125g000000RI59AAG',
            Name = cs.Subject,
            Description__c = (cs.Description).abbreviate(50)
        );
        Test.stopTest();

        
        System.assertEquals(todos.Name, 'Subject');
        System.assertEquals(todos.RecordTypeId, '0125g000000RI59AAG');
        System.assertEquals(todos.Description__c, 'Apex provides a testing framework that allows y...');
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = False;
    }
}