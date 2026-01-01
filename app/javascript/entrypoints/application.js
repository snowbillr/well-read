import * as Turbo from '@hotwired/turbo'
import { Application } from "@hotwired/stimulus"
import { registerControllers } from 'stimulus-vite-helpers'

// Start Turbo
Turbo.start()

// Start Stimulus
const application = Application.start()
const controllers = import.meta.glob('../controllers/*_controller.js', { eager: true })
registerControllers(application, controllers)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
