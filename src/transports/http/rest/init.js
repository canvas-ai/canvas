// Utils
const debug = require('debug')('canvas:transports:http:rest');

// Routes
//const schemasRoutes = require('./routes/v1/schemas');
//const contextsRoutes = require('./routes/v1/contexts');
const contextRoutes = require('./routes/v1/context');
const documentsRoutes = require('./routes/v1/documents');
//const bitmapRoutes = require('./routes/v1/bitmaps');
const sessionsRoutes = require('./routes/v1/sessions');

module.exports = (app, parent) => {
    debug('Initializing REST API routes');

    app.use(`${parent.restApiBasePath}/sessions`, (req, res, next) => {
        req.sessionManager = parent.sessionManager;
        req.ResponseObject = parent.ResponseObject;
        next();
    }, sessionsRoutes);

    // Routes related to the /context endpoint
    app.use(`${parent.restApiBasePath}/context`, (req, res, next) => {
        req.sessionManager = parent.sessionManager;
        req.context = parent.context;
        req.ResponseObject = parent.ResponseObject;
        next();
    }, contextRoutes);

    // Global documents endpoint
    app.use(`${parent.restApiBasePath}/documents`, (req, res, next) => {
        req.db = parent.canvas.documents;
        req.ResponseObject = parent.ResponseObject;
        next();
    }, documentsRoutes);
};
