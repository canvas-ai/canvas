/**
 * Canvas server
 */


// CLI Parser
const argv = require('minimist')(process.argv.slice(2));
// TODO: Implement CLI parser in ./cli

// Canvas
const Canvas = require('./main');
const canvas = new Canvas();

// Start the server
canvas.start();

// Event
canvas.on('running', () => {
    console.log('Canvas server started successfully.');
});
