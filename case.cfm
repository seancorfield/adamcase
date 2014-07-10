<cfscript>
// case.cfm
struct function case(){
    var requireCondition = function(condition){
        condition ?: throw(type="MissingArgumentException")
        !isBoolean(condition) && !isCustomFunction(condition) && !isClosure(condition) &&
            throw(type="InvalidArgumentException")
    }
    var requireValue = function(value){
        value ?: throw(type="MissingArgumentException")
        !isCustomFunction(value) && !isClosure(value) &&
            throw(type="InvalidArgumentException")
    }
    return {
        when = function(condition){
            requireCondition(argumentCollection=arguments)
            if ( isBoolean( condition ) ? condition :
                 ( condition() ?: false ) ) {
                return {
                    then = function(value){
                        requireValue(argumentCollection=arguments)
                        var result = value()
                        var ender   = {
                            end  = function(){
                                return result ?: javaCast("null","")
                            }
                        }
                        var whenner = { }
                        var thenner = {
                            when = function(condition){
                                requireCondition(argumentCollection=arguments)
                                return whenner
                            },
                            else = function(value){
                                requireValue(argumentCollection=arguments)
                                return ender
                            },
                            end = ender.end
                        }
                        whenner.then = function(condition){
                            requireCondition(argumentCollection=arguments)
                            return thenner
                        }
                        return thenner
                    }
                }
            } else {
                return {
                    then = function(value){
                        return {
                            when = case().when,
                            else = function(value){
                                requireValue(argumentCollection=arguments)
                                var result = value()
                                return {
                                    end = function(){
                                        return result ?: javaCast("null","")
                                    }
                                }
                            },
                            end = function(){ return javaCast("null","") }
                        }
                    }
                }
            }
        }
    }
}
</cfscript>
