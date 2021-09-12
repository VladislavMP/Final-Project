public class CreateToDoEmail {
     public static void TodoInsert(List<Case> cases) { 
             List<ToDo__c> todos = new List<ToDo__c>();
             List<ToDo__c> Taske =[SELECT  RecordTypeId FROM ToDo__c];
             List<Id> Ids = new List<Id>();
             for(ToDo__c y: Taske){
                    Ids.add( y.RecordTypeId);}
              
            for (Case cs : cases) {
                if (cs.Origin == 'Email') {
                    ToDo__c todo = new ToDo__c(
                        Name = cs.Subject);
                    todos.add(todo);}}
            insert todos;}}