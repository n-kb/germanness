const PrerenderSPAPlugin = require('prerender-spa-plugin');

const Renderer = PrerenderSPAPlugin.PuppeteerRenderer;
const path = require('path');

module.exports = {
	configureWebpack: config => {
	    if (process.env.NODE_ENV !== 'prerender') return;
	    return {
	      plugins: [
	        new PrerenderSPAPlugin({
	          staticDir: path.join(__dirname, '/dist/'),
	          routes: ['/', '/en/', '/fr/', '/de/'],
	          minify: {
	            collapseBooleanAttributes: true,
	            collapseWhitespace: true,
	            decodeEntities: true,
	            keepClosingSlash: true,
	            sortAttributes: true,
	          },
	          renderer: new Renderer({
	            //renderAfterElementExists: '#app'
	            renderAfterTime: 20000,
	            headless: false
	          }),
	        }),
	      ],
	    };
	},

	baseUrl: process.env.NODE_ENV === 'production'
	? '/germanness/'
	: '/'
}