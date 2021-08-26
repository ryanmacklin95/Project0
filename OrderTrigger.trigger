trigger OrderTrigger on Order (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    // We should be able to handle every case
    switch on trigger.operationType {
        when BEFORE_INSERT {
            
        }
        when BEFORE_UPDATE {
            
        }
        when BEFORE_DELETE {

        }
        when AFTER_INSERT { 
            
        }
        when AFTER_UPDATE { 
			orderTriggerHandler.sendOrderEmail(trigger.new);
        }
        when AFTER_DELETE { 

        }
        when AFTER_UNDELETE {
            
        }
	}
}