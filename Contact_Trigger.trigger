trigger Contact_Trigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT { // Fires on Upsert
        	triggerHandler.quickAccount(trigger.new);
        }
        when BEFORE_UPDATE { // Fires on Upsert and Merge

        }
        when BEFORE_DELETE { // Fires on Merge
           
        }
        when AFTER_INSERT { // Fires on Upsert
        	triggerHandler.validateAccounts(trigger.new);
        }
        when AFTER_DELETE { // Fires on Merge
            
        }
        when AFTER_UNDELETE {

        }
        when AFTER_UPDATE { // Fires on Upsert and Merge
            triggerHandler.validateAccounts(trigger.new);
        }
    }
}