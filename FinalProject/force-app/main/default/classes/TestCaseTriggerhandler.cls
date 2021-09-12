@isTest
public class TestCaseTriggerhandler {
	@IsTest
    static void testcreateCaseTodo() {
        List<Case> cases = new List<Case>();
        Case cs = new Case();
        cs.Origin = 'Email';
        cs.Subject = 'Subject';
        List<Id> Ids = new List<Id>();
        
        cases.add(cs);
        List<ToDo__c> todos = new List<ToDo__c>();

        Test.startTest();
        CreateToDoEmail.TodoInsert(cases);
        todos = [SELECT RecordTypeId FROM ToDo__c Limit 1];
        Test.stopTest();

        System.assertEquals(todos.size(), 1);
        for (ToDo__c todo : todos) {
            System.assertEquals(todo.Name, 'Subject');
            System.assertEquals(todo.RecordTypeId, todo.RecordTypeId);
            Ids.add(todo.RecordTypeId);
        }
    }
}