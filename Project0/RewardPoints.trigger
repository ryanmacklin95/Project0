trigger RewardPoints on Order (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	switch on trigger.operationType {
        when BEFORE_INSERT { 
            System.debug('before insert triggered');
            SupplierValidationHandler.correctOrders(trigger.new);
        }
        when BEFORE_UPDATE { 
            
        }
        when BEFORE_DELETE { 
            
        }
        when AFTER_INSERT { 
            
        }
        when AFTER_UPDATE { 
            RewardPointsHandler.updatePoints(trigger.new);
        }
        when AFTER_DELETE { 
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}