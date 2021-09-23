public class CreateToDoEmailHelper {
	private static final String END_OF_SUBSTRING = '.';
    private static final String START_OF_SUBSTRING = ':';
    private static final String SEPARATOR = ',';
    private static final String TODO_NAME_FIELD = 'Name';
    private static final String TODO_RECORD_TYPE_FIELD = 'RecordType';
    private static final String SUB_TODOS_NAME_FIELDS = 'SubToDos';

    
    // Функция принимает тело имэйла, список названий полей с одним значением и список названий полей с несколькими значениями
    public static String parcingSubject(String subject) {
 
        JSONGenerator generator = JSON.createGenerator(true);
        
		generator.writeStartObject();
        generator.writeObjectField(
            TODO_NAME_FIELD, findField(TODO_NAME_FIELD, subject)); 
        generator.writeObjectField(
            TODO_RECORD_TYPE_FIELD, findField(TODO_RECORD_TYPE_FIELD, subject));
        generator.writeObjectField(
            SUB_TODOS_NAME_FIELDS, findFieldWithSeveralValues(SUB_TODOS_NAME_FIELDS, subject));
        generator.writeEndObject();    
        String jsonString = generator.getAsString();
            
        return jsonString;
    }
    
    public static List<String> findFieldWithSeveralValues(String fieldName, String subject) {
        Integer firstIndex;
        Integer secondIndex;
        Integer thirdIndex;
		List<String> fields = new List<String>();    
        
        firstIndex = subject.indexOf(fieldName);
        if(firstIndex == -1) {
            return fields;
        }
		firstIndex = subject.indexOf(START_OF_SUBSTRING, firstIndex);
		thirdIndex = subject.indexOf(END_OF_SUBSTRING, firstIndex);
        if(thirdIndex == -1) {
            thirdIndex = subject.length();
        }
            
		while(firstIndex != thirdIndex) {
         	secondIndex = subject.indexOf(SEPARATOR, firstIndex + 1);
         	if(!(secondIndex < thirdIndex) || secondIndex == -1) {
             	secondIndex = thirdIndex;
         	}
            fields.add(
       			subject.substring(firstIndex + 1, secondIndex).trim());
    		firstIndex = secondIndex;
		}
        
        return fields;
    }
    
    public static String findField(String fieldName, String subject) {
        Integer firstIndex;
        Integer secondIndex;
		String field;    
        firstIndex = subject.indexOf(fieldName);
        if (firstIndex == -1) {
            return 'Not Found';
        }
		firstIndex = subject.indexOf(START_OF_SUBSTRING, firstIndex);
		secondIndex = subject.indexOf(END_OF_SUBSTRING, firstIndex);
		if(firstIndex != -1) {
    		if (secondIndex != -1) {
       			field = subject.substring(firstIndex + 1, secondIndex).trim();
    		} else {
       			field = subject.substring(firstIndex + 1).trim();
    		}
		}
        
        return field;
    }
}