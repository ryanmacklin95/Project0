@isTest
public class ContactHandlerTest 
{
    @testSetup
    public static void TestSetup()
    {
        List<Contact> toInsert = new List<Contact>();
        For(Integer i = 0; i < 151; i++)
            toInsert.add(new Contact(lastName = 'Test Contact ' + i));
        
        Insert toInsert;
    }
    
	@isTest
    public static void TP_SetRecordType()
    {
        Test.startTest();
        Integer numValid = 0;
        
        List<Contact> someContacts = [SELECT recordTypeID FROM Contact];
        
        for(Contact thisContact : someContacts)
        {
            if(thisContact.recordTypeId == '0125e000001sOSmAAM')
            {
                numValid++;
            }
        }
        
        System.assertEquals(151, numValid);
        Test.stopTest();
    }
    
    @isTest
    public static void TN_SetRecordType()
    {
        Test.startTest();
        Integer numValid = 0;
        
        List<Contact> someContacts = [SELECT lastName FROM Contact WHERE lastName LIKE 'Ted%'];
        
        for(Contact thisContact : someContacts)
        {
            if(thisContact.recordTypeId == '0125e000001sOSmAAM')
                numValid++;
        }
        
        System.assertEquals(0, numValid);
        Test.stopTest();
    }
    
    @isTest
    public static void TP_NewContact()
    {
        Test.startTest();
        Integer numValid = 0;
        
        List<Contact> someContacts = [SELECT lastName, accountId FROM Contact];
	
		for(Contact thisContact : someContacts)        
        {
            if(thisContact.AccountId == '0015e00000JQ1E1AAL')
            {
                numValid++;
            }
        }
        
        System.assertEquals(151, numValid);
        Test.stopTest();
    }
    
    @isTest
    public static void TN_NewContact()
    {
        Test.startTest();
        Integer numValid = 0;
        
        List<Contact> someContacts = ContactTestHelper.CreateContacts(1);
	
		for(Contact thisContact : someContacts)        
        {
            if(thisContact.AccountId == '0015e00000JQ1E1AAL')
                numValid++;
        }
        
        System.assertEquals(0, numValid);
        Test.stopTest();
    }
    
}