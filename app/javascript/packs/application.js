// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// import the bootstrap javascript module
import "bootstrap"

// import the application.scss we created for the bootstrap CSS (if you are not using assets stylesheet)
import "../stylesheets/application"
var jQuery = require('jquery')

// include jQuery in global and window scope (so you can access it globally)
// in your web browser, when you type $('.div'), it is actually refering to global.$('.div')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

import "../vendor/modernizr/modernizr.custom.js"
import "../vendor/js-storage/js.storage.js"
import "../vendor/i18next/i18next.js"
import "../vendor/i18next-xhr-backend/i18nextXHRBackend.js"
import "../vendor/jquery/dist/jquery.js"
import "../vendor/popper.js/dist/umd/popper.js"
import "../vendor/bootstrap/dist/js/bootstrap.js"
import "../vendor/parsleyjs/dist/parsley.js"
import "../vendor/@fortawesome/fontawesome-free/css/brands.css"
import "../vendor/@fortawesome/fontawesome-free/css/regular.css"
import "../vendor/@fortawesome/fontawesome-free/css/solid.css"
import "../vendor/@fortawesome/fontawesome-free/css/fontawesome.css"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
