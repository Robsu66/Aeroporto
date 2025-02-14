trigger VooTrigger on Voo__c (after insert, after update) {
    if(Trigger.isInsert || Trigger.isUpdate){
        if(VooTriggerAfterInsert.isAfterInsert) return;
        VooTriggerAfterInsert.isAfterInsert = true;
        VooTriggerAfterInsert.calculaDistanciaHelper();
    }
}