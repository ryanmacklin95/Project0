public class SupplyHandler 
{
    public static void AddDefaultFields(List<Supply__c> newSupplies)
    {        
        id defaultAccount = '0015e00000JQ1E1AAL';
        id defaultInventory = 'a005e0000066GF2AAM';
        
        for(Supply__C thisSupply : newSupplies)
        {   
            if(thisSupply.Account__c != defaultAccount && thisSupply.Inventory__c != defaultInventory)
            {
                thisSupply.Account__c = defaultAccount;
                thisSupply.Inventory__c = defaultInventory;
            }
        }
    }

}


/*
Execute Anonymous Code:

List<Supply__c> toUpdate = [SELECT In_Stock__C, Account__r.Need_To_Contact__c FROM Supply__c];

for(Supply__c thisSupply : toUpdate) 
{
    toUpdate.In_stock__c = 'false';
}
Database.update(toUpdate, false);
*/



/*

List<Supply__C> toInsert = new List<Supply__C>;

for(integer i = 0; i < 5; i++)
{
    toInsert.add(new Supply__c(name = 'Default name ' + i));
}

Database.insert(toInsert, false);



*/