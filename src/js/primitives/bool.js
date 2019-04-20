class Crystal__Bool {
    constructor(val) {
        this.value = Boolean(val);
    }

    toString() {
        return this.value ? "true" : "false";
    }

    __EQUAL____EQUAL__(other) {
        if(other instanceof Crystal__Bool) {
            return new Crystal__Bool(this.value === other.value)
        }
        return new Crystal__Bool(false);
    }

    __AMPERSAND__(other) {
        return new Crystal__Bool(this.value && other.value);
    }

    __PIPE__(other) {
        return new Crystal__Bool(this.value || other.value);
    }
}
