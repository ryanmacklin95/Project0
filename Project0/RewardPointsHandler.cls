public class RewardPointsHandler {
    
    public static void updatePoints(List<Order> newOrders){
        set<ID> accountIDs = new Set<ID>();
        set<ID> orderIDs = new SET<ID>();
        
        for(Order o : newOrders){
            accountIDs.add(o.accountid);
            orderIDs.add(o.Id);
        }
        
        List<Account> toUpdate = [Select RewardPoints__c, (Select TotalAmount, RecordTypeID From Orders WHERE status = 'Activated' AND ID IN : orderIDs) 
                                  FROM Account WHERE ID IN : accountIDs];
        
        for(Integer i = 0; i < toUpdate.size(); i++){            
            toUpdate[i].RewardPoints__c += CalculateTotalAmount(toUpdate[i].orders);
        }
        
        Update toUpdate;
    }
    
    private static Boolean isCustomerOrder(Order currOrder){
        if(currOrder.RecordTypeId == '0125e0000007mw2'){
            return true;
        }
        
        return false;
    }
    
    private static Integer CalculateTotalAmount(List<Order> allOrders){
        Long totalRewards = 0;
        
        for(Order o : allOrders){
            if(isCustomerOrder(o)){
            	totalRewards += o.TotalAmount.round(System.RoundingMode.DOWN);
            }
        }
        
        return totalRewards.intValue();
    }
    
}