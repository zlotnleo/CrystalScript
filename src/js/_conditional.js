function Crystal__conditional(arg) {
    if(arg instanceof Crystal__Bool) {
        return arg.value
    }
    if(arg instanceof Crystal__Nil) {
        return false
    }
    return true
}
