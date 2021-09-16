public class CreateToDoEmailHelper {
	
    // Функция принимает тело имэйла, список названий полей с одним значением и список названий полей с несколькими значениями
    public static String parcingSubject(
        String subject, List<String> fieldsWithOneValueNames, List<String> fieldsWithSeveralValuesNames){
            
        Map<String, String> fieldsWithOneValueMap = new Map<String, String>();
        Map<String, List<String>> fieldsWithSeveralValuesMap = new Map<String, List<String>>();
        
        for(String fieldName : fieldsWithOneValueNames) {
        	fieldsWithOneValueMap.put(fieldName, findField(fieldName, subject));
        }
        for(String fieldName : fieldsWithSeveralValuesNames) {
        	fieldsWithSeveralValuesMap.put(fieldName, findFieldWithSeveralValues(fieldName, subject));
        }

        JSONGenerator generator = JSON.createGenerator(true);
        
		generator.writeStartObject();
        generator.writeObjectField('fieldsWithOneValue', fieldsWithOneValueMap); 
        generator.writeObjectField('fieldsWithSeveralValues', fieldsWithSeveralValuesMap);
        generator.writeEndObject();    
        String jsonString = generator.getAsString();
            
        return jsonString;
    }
    
    public static List<String> findFieldWithSeveralValues(String fieldName, String subject){
        Integer firstIndex;
        Integer secondIndex;
        Integer thirdIndex;
		List<String> fields = new List<String>();    
        
        firstIndex = subject.indexOf(fieldName);
        if (firstIndex == -1) {
            return fields;
        }
		firstIndex = subject.indexOf(':', firstIndex);
		thirdIndex = subject.indexOf('.', firstIndex);
        if(thirdIndex == -1) thirdIndex = subject.length();
            
		while(firstIndex != thirdIndex) {
         	secondIndex = subject.indexOf(',', firstIndex + 1);
         	if(!(secondIndex < thirdIndex) || secondIndex == -1)
         	{
             	secondIndex = thirdIndex;
         	}
            fields.add(
       			subject.substring(firstIndex + 1, secondIndex).trim());
            
    		firstIndex = secondIndex;
		}
        
        return fields;
    }
    
    public static String findField(String fieldName, String subject){
        Integer firstIndex;
        Integer secondIndex;
		String field;    
        firstIndex = subject.indexOf(fieldName);
        if (firstIndex == -1) {
            return '';
        }
		firstIndex = subject.indexOf(':', firstIndex);
		secondIndex = subject.indexOf('.', firstIndex);
		if(firstIndex != -1){
    		if (secondIndex != -1){
       			field = subject.substring(firstIndex + 1, secondIndex).trim();
    		} else {
       			field = subject.substring(firstIndex + 1).trim();
    		}
		}
        
        return field;
    }
}