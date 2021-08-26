public class ProductTriggerHandler {
    
    public static void productFieldDefault(List<Product2> productToChange){
    	// after a product is made I want it to be autommactily have the discription field 
		// filled with a defult value
		
    	for (Product2 needChange: productToChange){
            if (needChange.Room_Description__c == null){
    			needChange.Room_Description__c = 'Room description is unavailable, Please wait for Admin to update.';
            }
            if (needChange.Meal_Deiscription__c == null){
        		needChange.Meal_Deiscription__c = 'Meal description is unavailable, Pleas wait for Admin to update.';
            }
			if (needChange.ProductCode == null){
        		needChange.ProductCode = 'PC-000';
            }
		}
    }
}