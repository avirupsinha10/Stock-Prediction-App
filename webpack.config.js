const path = require('path');

module.exports = {
    mode: "development",
    entry: {
        app:"./src/main/index.bs.js"
    },
    devServer: {
    contentBase: path.join(__dirname, "dist"),
    } ,
    output: {
    path: path.resolve(__dirname, 'dist'),
    }
};