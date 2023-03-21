// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

// esbuild-plugin-stimulus
// const esbuild = require('esbuild');
// const { stimulusPlugin } = require('esbuild-plugin-stimulus');

// esbuild.build({
//   entryPoints: ['src/index.js'],
//   bundle: true,
//   outfile: 'dist/index.js',
//   plugins: [stimulusPlugin()],
// }).catch(() => process.exit(1));


// 読み込めない(package.json Debug)
// import "popper"

Turbo.session.drive = false