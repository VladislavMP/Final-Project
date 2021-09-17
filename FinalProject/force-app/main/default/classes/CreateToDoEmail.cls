public class CreateToDoEmail {
        public static void todoInsert(List<Case> cases) { 
                List<ToDo__c> todos = new List<ToDo__c>();
                for (Case cs : cases) {
                   if (cs.Origin == 'Email') {
                           ToDo__c todo = new ToDo__c(
                           Name = cs.Subject,
                           RecordTypeId = '0125g000000RI59AAG',
                           Description__c = (cs.Description).abbreviate(50));
                       todos.add(todo);}
               }Insert todos;}
   
               
               
    // public static void todoInsert(List<Case> cases) { 
      //   	 String jsonString =  CreateToDoEmailHelper.parcingSubject('subject',new List<String>{'Name', 'Record Type'}, new List<String>{'Sub-ToDos'});
         	 
        //     List<ToDo__c> todos = new List<ToDo__c>();
          //   List<ToDo__c> Taske =[SELECT  RecordTypeId FROM ToDo__c];
         	// Boolean tree = True;
             //EmailEntity entity = (EmailEntity) Json.Deserialize(jsonString, EmailEntity.class);
            // entity.fieldsWithOneValue.get('Name');
			// entity.fieldsWithSeveralValues.get('Sub-ToDos');
            // List<String> entityString = new List<String>(entity.fieldsWithSeveralValues.get('Sub-ToDos'));
              
            // for (Case cs : cases) {
            //    While(tree == True) {
                //    ToDo__c todo = new ToDo__c(
              //      Name = entity.fieldsWithOneValue.get('Name'),
                  //  RecordTypeId = entity.fieldsWithOneValue.get('Record Type'));
                 //   todos.add(todo);
                //    Insert todos;
                //    tree = false;
                 //   While(tree == True){
                 //       for(ToDo__c sub: todos ){
                 //           for(String en:entityString){
                // 		Sub_ToDo__c subs = new Sub_ToDo__c(
                 //           ToDo__c = sub.Id,
                 //           Name = en
                  //      );Insert subs;
                    //      tree = false;}
                    //    }
                		
                        
                  //  }}
           // for(ToDo__c sub: todos ){
              //   Sub_ToDo__c subs = new Sub_ToDo__c(
                 //ToDo__c = sub.Id
                // Name = entity.fieldsWithSeveralValues.get('Sub-ToDos');
                // string recordtypeName = Schema.SObjectType.ToDo__c.getRecordTypeInfosById().get(y.RecordTypeId).getname();
               //  );
               // Insert subs;
                //  }	
        
  //   }

        /*public static void todoInsertT(List<Case> cases) { 

            List<ToDo__c> todos = new List<ToDo__c>();
			List<EmailEntity> entities = new List<EmailEntity>();
              
            for (Case cs : cases) {
                String jsonString =  CreateToDoEmailHelper.parcingSubject(cs.Subject);
         	 	EmailEntity entity = (EmailEntity) Json.Deserialize(jsonString, EmailEntity.class);
                entities.add(entity);
                 
                todos.add(new ToDo__c(
                    Name = entity.Name,
                    RecordTypeId = Schema.SObjectType.ToDo__c.getRecordTypeInfosByName().get(
                        entity.RecordType).getRecordTypeId()
                ));
			}
             
            insert todos;

            List<Sub_ToDo__c> subToDos = new List<Sub_ToDo__c>();
           	for(Integer i = 0; i < entities.size(); i++){
                List<String> subToDosNames = new List<String>(entities[i].SubToDos);
				Id toDoId = todos[i].Id;
                
                for(String subToDosName: subToDosNames ){
            		subToDos.add(new Sub_ToDo__c(
                		ToDo__c = toDoId,
                		Name = subToDosName
                	));
         		}
            }
            insert subToDos;
         }	*/
        
    
}