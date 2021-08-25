public class ContactHandler 
{
    
    public static void setRecordType(List<Contact> newContact)
    {
        id recordType = schema.SObjectType.Contact.getRecordTypeInfosByName().get('Supplier').getRecordTypeID();
        
        for(Contact thisContact : newContact)
        {
            	thisContact.RecordTypeID = recordType;
        }
    }
    
    
    public static void newContact(List<Contact> newContact)
    {
        id defaultAccount = '0015e00000JQ1E1AAL';
        for(Contact thisContact : newContact)
        {
            thisContact.accountId = defaultAccount;
        }

    }

}
/*
Execute Anonymous Code:
List<Account> myAccounts = new List<Account>();

for(Integer i = 0; i < 25; i++) 
{
    myAccounts.add(new Account(name = 'Acc ' + i));
}
Database.insert(myAccounts, false);
*/