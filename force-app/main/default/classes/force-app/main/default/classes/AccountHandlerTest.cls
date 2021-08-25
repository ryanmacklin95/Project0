@isTest
public class AccountHandlerTest 
{
    
    @testSetup
    public static void TestSetup()
    {
		List<Account> toInsert = new List<Account>();
        for(Integer i = 0; i < 151; i++)
            toInsert.add(new Account(name = 'Test Account ' + i));
        
        Insert toInsert;
    }
    
    @isTest
	public static void TP_UniqueAccountVerification()
    {
        Test.startTest();
        integer numValid = 0; 
        
        List<Account> someAccounts = [SELECT name FROM Account];
        
        for(Account thisAccount : someAccounts)
        {
           AccountHandler.UniqueAccountVerification(someAccounts, numValid);
        }
        
        System.AssertEquals(151, numValid);
        Test.stopTest();
        
    }
    
    @isTest
    public static void TN_UniqueAccountVerification()
    {
        Test.startTest();
        integer numValid = 0;
        
        List<Account> someAccounts = AccountHandlerTestHelper.CreateAccounts(1);
        
        for(Account thisAccount : someAccounts)
        {
           AccountHandler.UniqueAccountVerification(someAccounts, numValid);
        }
        
        System.AssertEquals(0, numValid);
        Test.stopTest();
    }
    
    @isTest
    public static void TRU_UniqueAccountVerification()
    {
        User restrictedUser = [SELECT name FROM User WHERE Profile.name = 'System Administrator' LIMIT 1];
        Integer numValid = 0;
        
        Test.startTest();
        
        System.runAs(restrictedUser)
        {
            List<Account> someAccounts = [SELECT name FROM Account LIMIT 1];
            
            for(Account thisAccount : someAccounts)
            {
                AccountHandler.UniqueAccountVerification(someAccounts, numValid);
            }
        }
        
        System.assertEquals(1, numValid);
        Test.stopTest();
    }
}