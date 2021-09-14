public class CreateToDoEmail {
     public static void todoInsert(List<Case> cases) { 
             List<ToDo__c> todos = new List<ToDo__c>();
             List<ToDo__c> Taske =[SELECT  RecordTypeId FROM ToDo__c Limit 1];
             
            
              
             for (Case cs : cases) {
                if (cs.Origin == 'Email') {
                    for(ToDo__c y: Taske){
                        string recordtypeName = Schema.SObjectType.ToDo__c.getRecordTypeInfosById().get(y.RecordTypeId).getname();
                        ToDo__c todo = new ToDo__c(
                        Name = cs.Subject,
                        RecordTypeId = y.RecordTypeId);
                    todos.add(todo);}}
            }Insert todos;}

            
            }