import { Application } from "@hotwired/stimulus"

console.log("✅ Stimulus booting...")

export const application = Application.start()

window.Stimulus = application
