import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';

// Connects to data-controller="pop-up"
export default class extends Controller {
  connect() {
  }

  confirmation() {
    Swal.fire({
      icon: "success",
      title: "Your request has been sent!",
      text: "The activity will appear in your dashboard if it is accepted by the host!",
      showCancelButton: true,
      cancelButtonText: `<a href="/dashboard" style="color: white;">Open Dashboard</a>`,
    })
    this.element.remove()
  }
}
