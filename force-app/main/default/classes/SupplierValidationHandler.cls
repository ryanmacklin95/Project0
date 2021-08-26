public with sharing class SupplierValidationHandler {
	
    public static Integer correctOrders(List<Order> newOrders){
        set<ID> orderIDs = new SET<ID>();
        set<ID> shipIDs = new SET<ID>();
        Integer added = 0;
            
        for(Order o : newOrders){
            //Check to see if this order is related to a shipment
            if(!(o.Shipment__c == NULL)){
                //Check to make sure that this order is a supply order record type
                if(o.RecordTypeId == '0125e0000007mvs'){
                    added++;
                    continue;
                }else{
                    o.addError('This order is not a supply order.');
                }
            }
        }
        
        return added;
    }
}