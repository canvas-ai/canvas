module.exports = [

    {
        id: '0000-0000-0000',
        type: 'universe',
        name: '/',
        label: 'Universe',
        description: 'And then, there was light',
        color: '#fff',
        locked: true,
    },

    /**
     * Canvas Server
     */

    {
        id: '0000-0000-1000',
        type: 'system',
        name: '.canvas',
        label: 'Canvas',
        description: 'Main Canvas server system tree',
        color: '#fff',
        locked: true,
    },

    // System
    // -- Services

    // Agents
    // Apps
    // Roles
    // Services
    // Data
    // Workspaces

    /**
     * Canvas clients
     */

    {
        id: '0000-0000-2001',
        type: 'system',
        name: '.session',
        label: 'Session',
        description: 'Current user session',
        color: '#fff',
        locked: true,
    },
    {
        id: '0000-0000-2002',
        type: 'system',
        name: '.user',
        label: 'User',
        description: 'Current user',
        color: '#fff',
        locked: true,
    },

];
