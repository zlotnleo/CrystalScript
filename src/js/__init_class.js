function init_class_vars() {
    if (!Object.prototype.hasOwnProperty.call(this, '__class_vars__')) {
        this.__class_vars__ = {};
    }
}

function set_custom_class_name(klass, name) {
    Object.defineProperty(klass.prototype.constructor, 'name', {value: name});
}