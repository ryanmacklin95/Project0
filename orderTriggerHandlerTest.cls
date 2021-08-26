@isTest
public class orderTriggerHandlerTest {
	
    @testSetup
    public static void setupOrderTest(){
        // In order to test orders without using SeeAllData=true I need an test account, Product, Pricebook, Order, and order item 
		// This will insert test Account
    	Account acc = new Account();
    	acc.Name = 'Order Trigger Test Account';
    	insert acc;

    	// This will insert test Product
    	Product2 testPro = new Product2();
    	testPro.Name = ' Test Product ';
    	testPro.Description='Test Product for Order trigger';
    	testPro.productCode = 'PC-001';
    	testPro.isActive = true;
    	insert testPro;
    
    	Id pricebookId = Test.getStandardPricebookId(); //this method I found returns ID of the Standard price book in my org without (SeeAllData=true)
        
    	// This will insert test PricebookEntry
    	PricebookEntry standardPrice = new PricebookEntry();
    	standardPrice.Pricebook2Id = pricebookId;
    	standardPrice.Product2Id = testPro.Id;
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
    	testOrder.AccountId = acc.id;
    	testOrder.Pricebook2Id =  pricebookId ;
    
    	insert testOrder;
    
    	// This will insert test Order Item
    	OrderItem testOrderIt = new OrderItem();
    	testOrderIt.OrderId = testOrder.id;
    	testOrderIt.Quantity = 24;
    	testOrderIt.UnitPrice = 240;
    	testOrderIt.Product2id = testPro.id;
    	testOrderIt.PricebookEntryId=standardPrice.id;
    	insert testOrderIt;
        
    }
    
    @isTest
    public static void TP_orderTriggerTest(){
        Test.startTest();
        
        Order toUpdateOrder = [SELECT Name, Order_Complete__c FROM Order WHERE Name = 'Test Order' Limit 1];        
        toUpdateOrder.Order_Complete__c = true;
        Update toUpdateOrder;
        
        System.assertEquals(true, toUpdateOrder.Order_Complete__c);
                
        Test.stopTest();
    }
}