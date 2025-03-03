document.addEventListener("DOMContentLoaded", function() {
  function fetchNotifications() {
    fetch("/notifications/recent", { headers: { "X-Requested-With": "XMLHttpRequest" } })
      .then(response => response.text())
      .then(html => {
        document.getElementById("notifications-list").innerHTML = html;

        // Update the notification count
        const count = document.querySelectorAll("#notifications-list .dropdown-item.bg-light").length;
        document.getElementById("notification-count").textContent = count > 0 ? count : "";
      })
      .catch(error => console.error("Error fetching notifications:", error));
  }

  // Fetch notifications every 10 seconds
  setInterval(fetchNotifications, 10000);
});
