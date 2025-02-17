public with sharing class InsereVoo {

    @AuraEnabled
    public static void createVoo(String vooInsert) {
        system.debug(vooInsert);
        Voo__c voo = (Voo__c) JSON.deserialize(vooInsert, Voo__c.class);
        insert voo;
    }
}
