// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import { Application } from "@hotwired/stimulus"
window.Stimulus = Application.start()

import MapToggleController from "./map_toggle_controller.js"
Stimulus.register("map-toggle", MapToggleController)
