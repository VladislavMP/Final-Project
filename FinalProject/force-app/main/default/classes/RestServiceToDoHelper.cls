public with sharing class RestServiceToDoHelper {

    public static Id getRecordTypeId(String recordTypeName) {
        Id recordTypeId = Schema.SObjectType.ToDo__c
            .getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        return recordTypeId;
    } 
    
    public static List<ToDo__c> unwrapToDos(List<ToDoWrapper> wrappers, Boolean isCreation) {
        List<ToDo__c> toDos = new List<ToDo__c>();
        List<String> recordTypeNames = new List<String>();
        for(ToDoWrapper wrapper : wrappers) {
        	toDos.add(wrapper.toDo);
        	recordTypeNames.add(wrapper.recordTypeName);
        }
        
        for(Integer i = 0; i < toDos.size(); i++) {
        	toDos[i].RecordTypeId = RestServiceToDoHelper.getRecordTypeId(recordTypeNames[i]);
            String externalId = toDos[i].External_Id__c;
        	toDos[i].External_Id__c = toDos[i].Id;
            if(isCreation) {
        		toDos[i].Id = null;
            } else {
                toDos[i].Id = externalId;
            }
        }
        
        return toDos;
	}
    
    public static Map<String, String> getToDosIdsMap(List<ToDo__c> toDos) {
		Map<String, String> toDosIdsMap = new Map<String, String>();
        for(Integer i = 0; i < toDos.size(); i++) {
            toDosIdsMap.put(toDos[i].External_Id__c, toDos[i].Id);
        }
        
        return toDosIdsMap;
    }

    public static List<ToDo__c> changeOwnerToIntegrationUser(List<ToDo__c> toDos) {
        User integrationUser = [SELECT Id FROM User WHERE Name = 'Integration User'];

        for(ToDo__c toDo : toDos) {
            toDo.OwnerId = integrationUser.Id;
        }

        return toDos;
    }
}