import { Application } from "@hotwired/stimulus"

console.log("✅ Stimulus booting...")

const application = Application.start()

application.debug = false
window.Stimulus   = application

export { application }
