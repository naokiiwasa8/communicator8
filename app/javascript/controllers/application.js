import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application

export { application }

// esbuild-plugin-stimulus
const esbuild = require('esbuild');
const { stimulusPlugin } = require('esbuild-plugin-stimulus');

esbuild.build({
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/index.js',
  plugins: [stimulusPlugin()],
}).catch(() => process.exit(1));