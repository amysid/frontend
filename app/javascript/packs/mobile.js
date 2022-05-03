
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

// js file

import "../mobile/js/jquery.js"
import "../mobile/js/bootstrap.js"
import "../mobile/js/audio-player.js"

// css file
import "../mobile/css/bootstrap.css"
import "../mobile/css/mobile.css"
import "../mobile/css/bootstrap-side-modals.css"