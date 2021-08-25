@isTest
public class SupplyHandlerTest 
{
    
	@testSetup
	public static void TestSetup()
    {
        List<Supply__c> toInsert = new List<Supply__c>();
        
        for(Integer i = 0; i < 151; i++)
        {
            toInsert.add(new Supply__c(name = 'Test Supply ' + i));
        }
        
        Insert toInsert;
    }
    
	@isTest
    public static void TP_AddDefaultFields()
    {
        Test.startTest();
        
        List<Supply__c> someSupplies = [SELECT name, Account__c, Inventory__c FROM Supply__c];
        Integer numValid = 0;
        
        for(Supply__c thisSupply : someSupplies)
        {
            if(thisSupply.Account__c == '0015e00000JQ1E1AAL' && thisSupply.Inventory__c == 'a005e0000066GF2AAM')
            {
                numValid++;
            }
        }
        
        System.assertEquals(151, numValid);
        Test.stopTest();
    }
    
    @isTest
    public static void TN_AddDefaultFields()
    {
        Test.startTest();
        Integer numValid = 0;
        
        List<Supply__c> someSupplies = [SELECT name FROM Supply__c WHERE name LIKE 'Rum'];
        
        for(Supply__c thisSupply : someSupplies)
        {
            if(thisSupply.Account__c != '0015e00000JQ1E1AAL' || thisSupply.Inventory__c != 'a005e0000066GF2AAM')
            {
                numValid++;
            }
        }
        System.assertEquals(0, numValid);
        
        Test.stopTest();
    }
    
    @isTest
    public static void TRU_AddDefaultFields()
    {
        User restrictedUser = [SELECT name FROM User WHERE Profile.name = 'System Administrator' LIMIT 1];
        Integer numValid = 0;
        
        Test.startTest();
        
        System.runAs(restrictedUser)
        {
            List<Supply__c> newSupplies = [SELECT name, Account__c, Inventory__c FROM Supply__c];
            
            for(Supply__c thisSupply : newSupplies)
            {
                if(thisSupply.Account__c == '0015e00000JQ1E1AAL' && thisSupply.Inventory__c == 'a005e0000066GF2AAM')
                {
                    numValid++;
                }
            }
        }
        
        System.assertEquals(151, numValid);
        Test.stopTest();
    }
}