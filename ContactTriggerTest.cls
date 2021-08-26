@isTest
public class ContactTriggerTest {
	
    @testSetup
    public static void SetupContactTest(){
        // setup some test contacts, these will be updated and compare with test methods
        List<Contact> conToInsert = new List<Contact>(); // This will create 151 contacts and check if each email is unique
        for(Integer num = 0; num < 151; num++) {
            conToInsert.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact '+num,
                Zip_Code__c = '77777',
                Email = 'tcontact'+num+'@email.com'));
        }
        
        Insert conToInsert;
    }
    
    @isTest
    public static void TP_emailCheck(){ // test a contact by updating an test contact, then make a new contact, both with unique emails to see that no error is called.  
        Test.startTest();
        
        Contact insertTestCon = new Contact(
            	FirstName = 'Test',
                LastName = 'Contact 777',
                Zip_Code__c = '77777',
                Email = 'inserttestcontact@email.com');
        
        Insert insertTestCon;
        System.assertEquals('inserttestcontact@email.com', insertTestCon.Email);

        
        Contact testCon = [SELECT Id, LastName, Email FROM Contact WHERE LastName = 'Contact 14' Limit 1];        
        testCon.Email = 'testemailcheck@email.com';
        Update testCon;
        System.assertNotEquals('tcontact14@email.com', testCon.Email);
                
        Test.stopTest();

    }
    
    @isTest
    public static void TN_emailCheck(){ // test a contact by updating an test contact, then make a new contact, both without unique emails to see that error is called.  
		Test.startTest();
        Boolean result = false;
        
        Contact insertTestCon1 = new Contact(
            	FirstName = 'Test',
                LastName = 'Contact 777',
                Zip_Code__c = '77777',
                Email = 'inserttestcontact1@email.com');
        
        Insert insertTestCon1;
        try {
            Contact insertTestCon2 = new Contact(
            	FirstName = 'Test',
                LastName = 'Contact 777',
                Zip_Code__c = '77777',
                Email = 'inserttestcontact1@email.com');
            
            Insert insertTestCon2;
            
        } catch(DmlException ex){
            result=true;
        }
        
        System.assert(result);
        Test.stopTest();
    }
}