public class SupplierValidationHandler {
	
    public static void correctOrders(List<Order> newOrders){
        set<ID> orderIDs = new SET<ID>();
        set<ID> shipIDs = new SET<ID>();
        
        for(Order o : newOrders){
            if(!(o.Shipment__c == NULL)){
                if(isSupplyOrder(o)){
                    continue;
                }else{
                    o.addError('This order is not a supply order.');
                }
            }
        }
        
        /*List<Order> toUpdate = [SELECT RecordTypeID, (SELECT name FROM Shipments__r WHERE ID IN : shipIDs) FROM Order WHERE ID IN : orderIDs];
        System.debug(toUpdate);
        for(Integer i = 0; i < toUpdate.size(); i++){            
            if(isSupplyOrder(toUpdate[i])){
                System.debug('Updating order' + toUpdate[i]);
                continue;
            }else{
                toUpdate[i].addError('This order is not a supply order.');
            }
        }*/
    }
    
    private static boolean isSupplyOrder(Order toCheck) {
    	if(toCheck.RecordTypeId == '0125e0000007mvs'){
            return true;
        }
        return false;
    }
}