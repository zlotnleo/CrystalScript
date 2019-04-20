Crystal__Program.$crystal__method = function(funcs) {
    this.funcs = funcs;
}
Crystal__Program.$crystal__method.prototype.call = function(this_arg, block, ...arg_vals) {
    let num_args = arg_vals.length;
    let initial_match = this.funcs.filter(func => num_args >= func.min_args && num_args <= func.max_args && (block === func.has_block));

    /* BEGIN: Temporary until overloading on type */
    if(initial_match.length != 1) {
        throw `Found ${initial_match.length} mathing methods`;
    }
    let func = initial_match[0];
    /* END: Temporary until overloading on type */

    let external_check = Object.prototype.hasOwnProperty.call(func, 'external_names');
    let positional = [];
    let named = [];
    for(let arg of arg_vals) {
        if (Object.prototype.hasOwnProperty.call(arg, 'name')) {
            if (external_check && Object.prototype.hasOwnProperty.call(func.external_names, arg.name)) {
                arg.name = func.external_names[arg.name];
            }
            named.push(arg);    
        } else {
            positional.push(arg);
        }
    }
    let args = Object.create(null);
    for(let i = 0; i < positional.length; i++) {
        args[func.args[i].name] = positional[i].value;
    }
    for(let named_arg of named) {
        args[named_arg.name] = named_arg.value;
    }
    return func.func.call(this_arg, args);
};