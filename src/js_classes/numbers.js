class Crystal__Int32 {
    constructor(val) {
        if(typeof(val) === "string") {
            // val is a valid Crystal Int32
            // it fits into the JS range MIN_SAFE_INTEGER to MAX_SAFE_INTEGER
            this.value = parseInt(val)
        } else if (typeof(val) === "number") {
            this.value = val
        }
    }

    __PLUS__(other) {
        if(other instanceof Crystal__Int32) {
            let tmp = this.value + other.value
            if (tmp > this.constructor.MAX)
                return new Crystal__Int32(tmp - this.contructor.MAX)
            if (tmp < this.constructor.MIN)
                return new Crystal__Int32(tmp + this.constructor.MIN)
            return new Crystal__Int32(tmp)
        }
    }

    to_s() {
        return String(this.value)
    }
}
Crystal__Int32.MAX =  2147483647
Crystal__Int32.MIN = -21474836498
