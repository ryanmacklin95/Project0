trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
// befor insert and before update
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
            ContactTriggerHandler.emailCheck(trigger.new);
        }
        when BEFORE_UPDATE {
            ContactTriggerHandler.emailCheck(trigger.new);
        }
	}
}