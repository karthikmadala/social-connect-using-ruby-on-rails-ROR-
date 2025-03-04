// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"


document.addEventListener("turbo:load", function() {
  var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'))
  dropdownElementList.forEach(function (dropdownToggleEl) {
    new bootstrap.Dropdown(dropdownToggleEl)
  });
});
