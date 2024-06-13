// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "@rails/actioncable"


document.addEventListener("DOMContentLoaded", () => {

  setTimeout(() => {
    const flashMessages = document.querySelectorAll(".flash-message");
    flashMessages.forEach(message => {
      message.style.transition = "opacity 0.8s ease-out";
      message.style.opacity = "0";
      setTimeout(() => {
        message.remove();
      }, 500);
    });
  }, 6000);
});
