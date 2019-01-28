class Crystal_function {
    constructor(func, args, splat_index) {
        this.func = func;
        this.args = args;
        this.splat_index = splat_index;
    }

    call(call_this, ...arg_vals) {
        if (this.splat_index === undefined) {
            // No splat, maybe named arguments and a double splat
            let actual_vals = [];
            for(let i = 0; i < arg_vals.length; i++) {
                if (arg_vals[i].name !== undefined) {
                    // Named argument
                    let index = this.args.findIndex(elt => elt.name === arg_vals[i].name);
                    actual_vals[index] = arg_vals[i].value;
                }
            }
            for(let i = 0; i < this.args.length; i++) {
                if (actual_vals[i] !== undefined) {
                    // Already populated by a named argument
                    // Can't have any positional arguments after that
                    // continue instead of break because other arguments may need to be set to default
                    continue;
                }
                if (arg_vals[i] === undefined || arg_vals[i].name !== undefined) {
                    // if there is no argument, set value to default
                    // if it's a named argument, it's already been set by the first loop
                    actual_vals[i] = this.args[i].default;
                } else {
                    actual_vals[i] = arg_vals[i];
                }
            }
            this.func.call(call_this, ...actual_vals);
        } else {
            // No named arguments, splat does exist
        }
    }
}