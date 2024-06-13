import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    console.log("yeehaw")
    if (window.location.pathname === '/') { // Check if on homepage
      document.body.classList.add('no-scroll'); // Add no-scroll class
    }
  }

  disconnect() {
    document.body.classList.remove('no-scroll'); // Remove no-scroll class
  }
}
