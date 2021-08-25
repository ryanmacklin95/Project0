public class AccountHandler 
{
    public class CustomException extends System.Exception
    {
        
    }
    
    public static void UniqueAccountVerification(List<Account> someAccounts)
    {
        Integer i = 0;
         for(Account thisAccount : someAccounts)
        {
            if(thisAccount.name.Contains('Test Account ' + i)  )
            {
                System.debug('Failed Unique name verification.');
            }
            i++;
        }
    }
    
	public static Integer UniqueAccountVerification(List<Account> someAccounts, Integer numValid)
    {             
        Integer i = 0;
        for(Account thisAccount : someAccounts)
        {
            if(thisAccount.name.Contains('Test Account ' + i)  )
            {
                System.debug('Failed Unique name verification.');
            }else
            {
                numValid++;
            }
            
            i++;
        }
        
        return numValid;
    }
}