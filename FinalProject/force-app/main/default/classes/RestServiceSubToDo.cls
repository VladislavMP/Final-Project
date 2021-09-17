@RestResource(urlMapping='/Sub_ToDo__c/*')
global with sharing class RestServiceSubToDo {

    @HttpPost
    global static Map<String, String> createRecord(){
        RestRequest request = RestContext.request;
		List<Sub_ToDo__c> subToDos = (List<Sub_ToDo__c>) 
            JSON.deserialize(request.requestBody.toString(), List<Sub_ToDo__c>.class);
        subToDos = RestServiceSubToDoHelper.swapIdAndExternalId(subToDos, true);


        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert subToDos;
        
        Map<String, String> subToDosIdsMap = RestServiceSubToDoHelper.getSubToDosIdsMap(subToDos);
        return subToDosIdsMap;
    }

    @HttpDelete
    global static void deleteRecord(){
        RestRequest request = RestContext.request;
        List<String> subToDosIds = (List<String>) 
            JSON.deserialize(request.requestBody.toString(), List<String>.class);
        
        List<Sub_ToDo__c> subToDos = [
            SELECT Id 
            FROM Sub_ToDo__c 
            WHERE Id = :subToDosIds
        ];
        
        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        delete subToDos;
    }


    @HttpPatch
    global static Map<String, String> updateRecord(){
        RestRequest request = RestContext.request;
		List<Sub_ToDo__c> subToDos = (List<Sub_ToDo__c>) 
            JSON.deserialize(request.requestBody.toString(), List<Sub_ToDo__c>.class);
        subToDos = RestServiceSubToDoHelper.swapIdAndExternalId(subToDos, false);

        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update subToDos;
        
        Map<String, String> subToDosIdsMap = RestServiceSubToDoHelper.getSubToDosIdsMap(subToDos);
        return subToDosIdsMap;
    }
}