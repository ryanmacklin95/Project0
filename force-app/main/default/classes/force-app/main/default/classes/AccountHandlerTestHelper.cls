@isTest
public class AccountHandlerTestHelper 
{
	public static List<Account> CreateAccounts(Integer newAccounts)
    {
        List<Account> toReturn = new List<Account>();
        
        for(Integer i = 0; i < newAccounts; i++) 
        {
            toReturn.add(new Account(name = 'Test Account 1'));
        }
        
        return toReturn;
    }
}