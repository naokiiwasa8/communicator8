// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

// 読み込めない(package.json Debug)
// import "popper"

Turbo.session.drive = true