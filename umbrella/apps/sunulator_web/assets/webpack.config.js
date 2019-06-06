const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

// Ensure a NODE_ENV is also present
if (!process.env.NODE_ENV) {
  throw "No NODE_ENV set";
}

const IS_PRODUCTION = (process.env.NODE_ENV === "production");

const filenameFormat = IS_PRODUCTION ? "[name]-[contenthash:8]" : "[name]";
const chunkFilenameFormat = filenameFormat + ".chunk";

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    './js/app.js': ['./js/app.js'].concat(glob.sync('./vendor/**/*.js'))
  },
  output: {
    filename: `${filenameFormat}.js`,
    chunkFilename: `${chunkFilenameFormat}.js`,
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.flow$/,
        use: [
          {
            loader: 'ignore-loader'
          },
        ]
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader'
          },
        ]
      },
      {
        test: /\.css$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader
          },
          {
            loader: 'css-loader',
            options: { importLoaders: 1 },
          },
          {
            loader: 'postcss-loader',
            options: {
              ident: 'postcss',
              plugins: function() {
                return [
                  require('postcss-import')(),
                  require('tailwindcss'),
                  require('autoprefixer'),
                ];
              }
            }
          },
        ]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
  ]
});
