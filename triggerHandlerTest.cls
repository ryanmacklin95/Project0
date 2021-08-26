@isTest
public class triggerHandlerTest {
	@testSetup
    public static void setupTests() {
        // Setting up  mock order Account
        Account orderTestAccount = new Account(name = 'Test Account');
        iNSERT orderTestAccount;
        
        // test product
        Product2 testProd = new Product2();
        testProd.Name = 'Test Product';
        testProd.Description='Test Product for Order trigger';
        testProd.productCode = 'PC-001';
        testProd.isActive = true;
        insert testProd;

        Id pricebookId = Test.getStandardPricebookId(); //this method I found returns ID of the Standard price book in my org without (SeeAllData=true)

        // This will insert test PricebookEntry
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = testProd.Id;
        standardPrice.UnitPrice = 79.99;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;

        // This will insert test Order
        Order testOrder = new Order();
        testOrder.Name = 'Test Order';
        testOrder.Status = 'Draft';
        testOrder.EffectiveDate = system.today();
        testOrder.EndDate = system.today() + 4;
        testOrder.AccountId = orderTestAccount.id;
        testOrder.Pricebook2Id =  pricebookId;
        insert testOrder;
        
        // This will insert test Order Item
        OrderItem testOrderIt = new OrderItem();
        testOrderIt.OrderId = testOrder.id;
        testOrderIt.Quantity = 24;
        testOrderIt.UnitPrice = 240;
        testOrderIt.Product2id = testProd.id;
        testOrderIt.PricebookEntryId=standardPrice.id;
        insert testOrderIt;
        
        // Test accounts and Contact for TN_validate account
        List<Account> testAccounts = new List<Account>();
        Account testSupply = new Account();
        testSupply.name = 'Test Supply Account';
        testSupply.RecordTypeId = Schema.SObjectType.Account
                    			.getRecordTypeInfosbyName()
                           		.get('Supplier Account').getRecordTypeId();
        Account testCustomer = new Account();
        testCustomer.name = 'Test Customer Account';
        testSupply.RecordTypeId = Schema.SObjectType.Account
                    			.getRecordTypeInfosbyName()
                           		.get('Customer Account').getRecordTypeId();
        testAccounts.add(testSupply);
        testAccounts.add(testCustomer);
        Insert testAccounts;
        Contact testCon = new Contact(Firstname = 'Test', Lastname = 'Contact', AccountId = testCustomer.Id, 
                                      recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosbyName()
                           			  .get('Customer Contact').getRecordTypeId());
        Insert testCon;

        // creates test contact for TP_quick account
        List<Contact> testList = new List<Contact>();
        Contact testContact = new Contact(FirstName = 'John', LastName = 'Bush', BusinessID__c = 'Test Business', 
                                          recordTypeId = Schema.SObjectType.Contact
            			   				  .getRecordTypeInfosbyName()
                           				  .get('Supplier Contact').getRecordTypeId());
        testList.add(testContact);
        Insert testList;

    } 
    @isTest
    public static void TP_quickAccount() {
        Test.startTest();
        Contact con = [SELECT name, Account.ID FROM Contact WHERE Contact.BusinessID__c = 'Test Business'];
        Account acc = [SELECT ID FROM Account WHERE name = 'Test Business'];
        System.Equals(con.Account.ID, Account.ID);
        Test.stopTest();
    }
    @isTest
    public static void TP_orderEmail() {
        Test.startTest();
        Order testOrder = [SELECT status FROM Order WHERE Order.name = 'Test Order'];
        testOrder.status = 'Activated';
        Update testOrder;
        Test.stopTest();
    }
    @isTest
    public static void TN_validateAccount() {
        Test.startTest();
  		Contact testCon = [SELECT AccountId FROM Contact WHERE name = 'Test Contact'];
        Account testSupply = [SELECT Id FROM Account WHERE name = 'Test Supply Account'];
        try {
            testCon.AccountId = testSupply.Id;
        	Update(testCon);
        }
        catch(Exception e) {
            System.Assert(e.getMessage().contains('Account is not valid: Invalid Record Type'));
        }
        test.stopTest();
    }
}