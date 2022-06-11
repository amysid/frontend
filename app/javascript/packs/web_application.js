require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// import the bootstrap javascript module
// import "bootstrap"

// import the application.scss we created for the bootstrap CSS (if you are not using assets stylesheet)
// import "../stylesheets/application"
var jQuery = require('jquery')

// include jQuery in global and window scope (so you can access it globally)
// in your web browser, when you type $('.div'), it is actually refering to global.$('.div')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

// web js start here
import "../web_vendor/jquery/dist/jquery.js"
import "../web_vendor/bootstrap/dist/js/bootstrap.js"
import "../website-assets/js/plugins.js"
import "../website-assets/js/sly.min.js"
// web js end here

// Website css

import "../website-assets/css/bootstrap.css"
import "../web_vendor/@fortawesome/fontawesome-free/css/brands.css"
import "../web_vendor/@fortawesome/fontawesome-free/css/regular.css"
import "../web_vendor/@fortawesome/fontawesome-free/css/solid.css"
import "../web_vendor/@fortawesome/fontawesome-free/css/fontawesome.css"
import "../website-assets/css/new-css.css"
import "../website-assets/css/bootstrap.css"
import "../website-assets/css/style.css"
import "../website-assets/css/scroller.css"
import "../website-assets/css/audio-player.css"
import "../website-assets/css/main.css"

// website css end here
