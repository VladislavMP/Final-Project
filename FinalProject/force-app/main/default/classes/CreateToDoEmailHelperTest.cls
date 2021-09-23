@isTest
public class CreateToDoEmailHelperTest {

    private static final String TEST_SUBJECT = 
        'Name : Email to ToDo. RecordType: Today. SubToDos : Email to SubToDo 1, Email to SubToDo 2';
        

    @isTest
    public static void parcingSubjectTest() {       
     	String subject = TEST_SUBJECT;
		
        String jsonString = CreateToDoEmailHelper.parcingSubject(subject);
        EmailEntity entity = (EmailEntity) Json.Deserialize(jsonString, EmailEntity.class);
        
        System.assertEquals(entity.Name, 'Email to ToDo');
        System.assertEquals(entity.RecordType, 'Today');
        System.assertEquals(entity.SubToDos, new List<String>{'Email to SubToDo 1', 'Email to SubToDo 2'});   
    }
}