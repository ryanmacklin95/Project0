@isTest
public class ProductTriggerTest {
	
    @testSetup
    public static void setupProduct(){
        List<Product2> productToInsert = new List<Product2>(); // This will create 15 products and should fill some fields with defult values
        for(Integer num = 0; num < 15; num++) {
            productToInsert.add(new Product2(
                Name = 'Test Product '+num,
                Room_Floor__c = 'Floor 1'));
        }
        
        Insert productToInsert;
    }
    
    @isTest
    public static void TP_ProductTrigger(){
        Test.startTest();
        
        Product2 updateTestProd = [SELECT Id, Name,Room_Description__c, Meal_Deiscription__c,ProductCode FROM Product2 WHERE Name = 'Test Product 3' LIMIT 1];
        updateTestProd.Room_Description__c = 'Testing if trigger overwrites room description';
        
        Update updateTestProd;
        System.assertNotEquals(null, updateTestProd.Meal_Deiscription__c);
        System.assertEquals('Testing if trigger overwrites room description', updateTestProd.Room_Description__c);
                
        Test.stopTest();
    }
}