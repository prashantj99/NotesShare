window.onload = function () {
    var userId="";
    checkSessionStatus(userId);
};

// Function to check session status
function checkSessionStatus(userId) {
    fetch('/CheckSessionServlet')
        .then(response => response.json())
        .then(data => {
            if (data.sessionExpired || data.differentUser) {
                window.location.href = '/login_page.jsp'; 
            }
        })
        .catch(error => {
            console.error('Error checking session status:', error);
    });
}

