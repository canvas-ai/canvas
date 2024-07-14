
const ROLE_TYPES = [
    'service',
    'agent',
    'minion'
]

const DRIVERS = [
    'docker'
]


class Role {
    constructor(id, options) {
        this.id = null;
        this.name = null;
        this.description = null;
        this.type = 'service';
        this.driver = 'docker';
    }
}