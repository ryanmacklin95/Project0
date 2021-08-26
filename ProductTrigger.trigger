trigger ProductTrigger on Product2 (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	// before insert and update
	 
        switch on trigger.operationType {
        when BEFORE_DELETE {

        }
        when AFTER_INSERT { 
            
        }
        when AFTER_UPDATE { 
		
        }
        when AFTER_DELETE { 

        }
        when AFTER_UNDELETE {
            
        }
        when BEFORE_INSERT {
            ProductTriggerHandler.productFieldDefault(trigger.new);
        }
        when BEFORE_UPDATE {
            ProductTriggerHandler.productFieldDefault(trigger.new);
        }
	}
}