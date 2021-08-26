trigger Project0 on Order (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType{
        when BEFORE_INSERT {
            Project0Handlers.Match(trigger.new);
        }
        when BEFORE_UPDATE{
            
        }
        when BEFORE_DELETE{
            
        }

        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
        when AFTER_INSERT{
            Project0Handlers.addSupply(trigger.new);
        }
    }

    
}