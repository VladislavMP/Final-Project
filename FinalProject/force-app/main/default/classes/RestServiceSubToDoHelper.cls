public with sharing class RestServiceSubToDoHelper {
    
    public static List<Sub_ToDo__c> swapIdAndExternalId(List<Sub_ToDo__c> subToDos, Boolean isCreation) {

        for(Integer i = 0; i < subToDos.size(); i++) {
            String externalId = subToDos[i].External_Id__c;
        	subToDos[i].External_Id__c = subToDos[i].Id;
            if (isCreation) {
        		subToDos[i].Id = null;
            } else {
                subToDos[i].Id = externalId;
            }
        }
        
        return subToDos;
	}
    
    public static Map<String, String> getSubToDosIdsMap(List<Sub_ToDo__c> subToDos) {
		Map<String, String> subToDosIdsMap = new Map<String, String>();
        for(Integer i = 0; i < subToDos.size(); i++) {
            subToDosIdsMap.put(subToDos[i].External_Id__c, subToDos[i].Id);
        }
        
        return subToDosIdsMap;
    }
}