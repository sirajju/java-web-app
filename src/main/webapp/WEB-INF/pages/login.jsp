<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Demo Application</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  </head>
  <body>
    <!-- Background Animation -->
    <div class="bg-animation">
      <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
      </div>
    </div>

    <!-- Main Container -->
    <div class="container">
      <!-- Back to Home -->
      <div class="back-link">
        <a href="${pageContext.request.contextPath}/" class="back-btn">
          <i class="fas fa-arrow-left"></i>
          <span>Back to Home</span>
        </a>
      </div>

      <!-- Login Card -->
      <div class="login-card">
        <!-- Header -->
        <div class="login-header">
          <div class="logo">
            <i class="fas fa-code"></i>
          </div>
          <h1>Welcome Back</h1>
          <p>Sign in to your account to continue</p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty error}">
          <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
          </div>
        </c:if>
        
        <c:if test="${not empty message}">
          <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span>${message}</span>
          </div>
        </c:if>

        <!-- Login Form -->
        <form method="post" action="${pageContext.request.contextPath}/login" class="login-form" id="loginForm">
          <div class="form-group">
            <div class="input-wrapper">
              <i class="fas fa-user input-icon"></i>
              <input 
                type="text" 
                id="username" 
                name="username" 
                required 
                autocomplete="username"
              />
              <label for="username">Username</label>
            </div>
          </div>

          <div class="form-group">
            <div class="input-wrapper">
              <i class="fas fa-lock input-icon"></i>
              <input 
                type="password" 
                id="password" 
                name="password" 
                required 
                autocomplete="current-password"
              />
              <label for="password">Password</label>
              <button type="button" class="password-toggle" onclick="togglePassword()">
                <i class="fas fa-eye" id="passwordToggleIcon"></i>
              </button>
            </div>
          </div>

          <div class="form-options">
            <label class="checkbox-wrapper">
              <input type="checkbox" id="rememberMe" name="rememberMe">
              <span class="checkmark"></span>
              <span class="checkbox-label">Remember me</span>
            </label>
            <a href="#" class="forgot-link" onclick="showForgotPassword()">Forgot password?</a>
          </div>

          <button type="submit" class="login-btn" id="loginBtn">
            <span class="btn-text">Sign In</span>
            <div class="btn-loader">
              <div class="spinner"></div>
            </div>
          </button>
        </form>

        <!-- Demo Credentials -->
        <div class="demo-credentials">
          <div class="demo-header">
            <i class="fas fa-info-circle"></i>
            <span>Demo Credentials</span>
          </div>
          <div class="demo-items">
            <div class="demo-item" onclick="fillCredentials('admin', 'admin123')">
              <strong>Admin:</strong> admin / admin123
            </div>
            <div class="demo-item" onclick="fillCredentials('user', 'user123')">
              <strong>User:</strong> user / user123
            </div>
          </div>
        </div>

        <!-- Footer Links -->
        <div class="login-footer">
          <p>Don't have an account? <a href="#" onclick="showSignupInfo()">Sign up</a></p>
          <div class="footer-links">
            <a href="${pageContext.request.contextPath}/test">Test Page</a>
            <span>•</span>
            <a href="#" onclick="showHelp()">Help</a>
            <span>•</span>
            <a href="#" onclick="showPrivacy()">Privacy</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
      <div class="toast-content">
        <i id="toastIcon" class="fas fa-info-circle"></i>
        <span id="toastMessage"></span>
      </div>
    </div>

    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: 'Inter', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow-x: hidden;
      }

      /* Background Animation */
      .bg-animation {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: 0;
      }

      .floating-shapes {
        position: relative;
        width: 100%;
        height: 100%;
      }

      .shape {
        position: absolute;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        animation: float 6s ease-in-out infinite;
      }

      .shape:nth-child(1) {
        width: 80px;
        height: 80px;
        top: 20%;
        left: 10%;
        animation-delay: 0s;
      }

      .shape:nth-child(2) {
        width: 120px;
        height: 120px;
        top: 60%;
        left: 80%;
        animation-delay: 1s;
      }

      .shape:nth-child(3) {
        width: 60px;
        height: 60px;
        top: 10%;
        left: 70%;
        animation-delay: 2s;
      }

      .shape:nth-child(4) {
        width: 100px;
        height: 100px;
        top: 70%;
        left: 20%;
        animation-delay: 3s;
      }

      .shape:nth-child(5) {
        width: 40px;
        height: 40px;
        top: 30%;
        left: 60%;
        animation-delay: 4s;
      }

      .shape:nth-child(6) {
        width: 140px;
        height: 140px;
        top: 80%;
        left: 60%;
        animation-delay: 5s;
      }

      @keyframes float {
        0%, 100% {
          transform: translateY(0px) rotate(0deg);
        }
        50% {
          transform: translateY(-20px) rotate(180deg);
        }
      }

      /* Container */
      .container {
        position: relative;
        z-index: 1;
        width: 100%;
        max-width: 800px;
        min-width: 600px;
        padding: 2rem;
        margin: 0 auto;
      }

      /* Back Link */
      .back-link {
        margin-bottom: 2rem;
        text-align: center;
      }

      .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        color: rgba(255, 255, 255, 0.9);
        text-decoration: none;
        padding: 0.75rem 1.5rem;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        border-radius: 50px;
        transition: all 0.3s ease;
        font-weight: 500;
      }

      .back-btn:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
        color: white;
      }

      /* Login Card */
      .login-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-radius: 24px;
        padding: 3rem;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
        animation: slideUp 0.6s ease;
      }

      @keyframes slideUp {
        from {
          opacity: 0;
          transform: translateY(30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      /* Header */
      .login-header {
        text-align: center;
        margin-bottom: 2.5rem;
      }

      .logo {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
      }

      .logo i {
        font-size: 2rem;
        color: white;
      }

      .login-header h1 {
        font-size: 2.5rem;
        font-weight: 700;
        color: #333;
        margin-bottom: 0.5rem;
      }

      .login-header p {
        color: #666;
        font-size: 1.1rem;
      }

      /* Alerts */
      .alert {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 1rem 1.25rem;
        border-radius: 12px;
        margin-bottom: 1.5rem;
        font-weight: 500;
        animation: slideIn 0.3s ease;
      }

      .alert-error {
        background: rgba(239, 68, 68, 0.1);
        color: #dc2626;
        border: 1px solid rgba(239, 68, 68, 0.2);
      }

      .alert-success {
        background: rgba(16, 185, 129, 0.1);
        color: #059669;
        border: 1px solid rgba(16, 185, 129, 0.2);
      }

      @keyframes slideIn {
        from {
          opacity: 0;
          transform: translateX(-20px);
        }
        to {
          opacity: 1;
          transform: translateX(0);
        }
      }

      /* Form */
      .login-form {
        margin-bottom: 2rem;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .input-wrapper {
        position: relative;
      }

      .input-wrapper input {
        width: 100%;
        padding: 1.25rem 1.25rem 1.25rem 3.5rem;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        font-size: 1rem;
        background: rgba(255, 255, 255, 0.8);
        transition: all 0.3s ease;
        outline: none;
      }

      .input-wrapper input:focus {
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .input-wrapper input:focus + label,
      .input-wrapper input:not(:placeholder-shown) + label {
        transform: translateY(-30px) scale(0.85);
        color: #667eea;
        background: white;
        padding: 0 0.5rem;
      }

      .input-wrapper label {
        position: absolute;
        left: 3.5rem;
        top: 1.25rem;
        color: #666;
        transition: all 0.3s ease;
        pointer-events: none;
        transform-origin: left;
      }

      .input-icon {
        position: absolute;
        left: 1.25rem;
        top: 1.25rem;
        color: #666;
        font-size: 1.1rem;
        z-index: 2;
      }

      .password-toggle {
        position: absolute;
        right: 1.25rem;
        top: 1.25rem;
        background: none;
        border: none;
        color: #666;
        cursor: pointer;
        font-size: 1.1rem;
        padding: 0;
        transition: color 0.3s ease;
      }

      .password-toggle:hover {
        color: #667eea;
      }

      /* Form Options */
      .form-options {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
      }

      .checkbox-wrapper {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        cursor: pointer;
        position: relative;
      }

      .checkbox-wrapper input[type="checkbox"] {
        position: absolute;
        opacity: 0;
        cursor: pointer;
      }

      .checkmark {
        width: 20px;
        height: 20px;
        background: white;
        border: 2px solid #e2e8f0;
        border-radius: 4px;
        position: relative;
        transition: all 0.3s ease;
      }

      .checkbox-wrapper input:checked ~ .checkmark {
        background: #667eea;
        border-color: #667eea;
      }

      .checkbox-wrapper input:checked ~ .checkmark::after {
        content: "✓";
        position: absolute;
        top: -2px;
        left: 3px;
        color: white;
        font-size: 14px;
        font-weight: bold;
      }

      .checkbox-label {
        color: #666;
        font-size: 0.9rem;
        user-select: none;
      }

      .forgot-link {
        color: #667eea;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 500;
        transition: color 0.3s ease;
      }

      .forgot-link:hover {
        color: #5a67d8;
        text-decoration: underline;
      }

      /* Login Button */
      .login-btn {
        width: 100%;
        padding: 1.25rem;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        margin-bottom: 2rem;
      }

      .login-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
      }

      .login-btn:active {
        transform: translateY(0);
      }

      .login-btn.loading .btn-text {
        opacity: 0;
      }

      .login-btn.loading .btn-loader {
        opacity: 1;
      }

      .btn-loader {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        opacity: 0;
        transition: opacity 0.3s ease;
      }

      .spinner {
        width: 20px;
        height: 20px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        border-top-color: white;
        animation: spin 1s linear infinite;
      }

      @keyframes spin {
        to {
          transform: rotate(360deg);
        }
      }

      /* Demo Credentials */
      .demo-credentials {
        background: rgba(102, 126, 234, 0.05);
        border: 1px solid rgba(102, 126, 234, 0.1);
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 2rem;
      }

      .demo-header {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #667eea;
        font-weight: 600;
        margin-bottom: 1rem;
        font-size: 0.9rem;
      }

      .demo-items {
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
      }

      .demo-item {
        padding: 0.75rem 1rem;
        background: rgba(255, 255, 255, 0.7);
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 0.9rem;
        border: 1px solid rgba(102, 126, 234, 0.1);
      }

      .demo-item:hover {
        background: rgba(102, 126, 234, 0.1);
        border-color: #667eea;
        transform: translateX(5px);
      }

      .demo-item strong {
        color: #667eea;
      }

      /* Footer */
      .login-footer {
        text-align: center;
        color: #666;
      }

      .login-footer p {
        margin-bottom: 1rem;
      }

      .login-footer a {
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
      }

      .login-footer a:hover {
        color: #5a67d8;
        text-decoration: underline;
      }

      .footer-links {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 1rem;
        font-size: 0.9rem;
      }

      .footer-links span {
        color: #ccc;
      }

      /* Toast Notification */
      .toast {
        position: fixed;
        top: 2rem;
        right: 2rem;
        background: white;
        border-radius: 12px;
        padding: 1rem 1.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        transform: translateX(400px);
        transition: transform 0.3s ease;
        z-index: 1001;
        max-width: 300px;
      }

      .toast.show {
        transform: translateX(0);
      }

      .toast-content {
        display: flex;
        align-items: center;
        gap: 0.75rem;
      }

      .toast.success i {
        color: #10b981;
      }

      .toast.error i {
        color: #ef4444;
      }

      .toast.info i {
        color: #3b82f6;
      }

      /* Responsive Design */
      @media (max-width: 768px) {
        .container {
          padding: 1rem;
          min-width: unset;
          max-width: 90%;
        }

        .login-card {
          padding: 2rem;
        }

        .login-header h1 {
          font-size: 2rem;
        }

        .form-options {
          flex-direction: column;
          gap: 1rem;
          align-items: flex-start;
        }

        .demo-items {
          gap: 0.5rem;
        }

        .footer-links {
          flex-wrap: wrap;
        }
      }

      @media (max-width: 480px) {
        .container {
          min-width: unset;
          max-width: 95%;
          padding: 0.5rem;
        }

        .login-card {
          padding: 1.5rem;
        }

        .login-header h1 {
          font-size: 1.8rem;
        }

        .toast {
          top: 1rem;
          right: 1rem;
          left: 1rem;
          max-width: none;
        }
      }
    </style>

    <script>
      // Toggle password visibility
      function togglePassword() {
        const passwordInput = document.getElementById('password');
        const toggleIcon = document.getElementById('passwordToggleIcon');
        
        if (passwordInput.type === 'password') {
          passwordInput.type = 'text';
          toggleIcon.className = 'fas fa-eye-slash';
        } else {
          passwordInput.type = 'password';
          toggleIcon.className = 'fas fa-eye';
        }
      }

      // Fill demo credentials
      function fillCredentials(username, password) {
        document.getElementById('username').value = username;
        document.getElementById('password').value = password;
        
        // Trigger label animations
        document.getElementById('username').dispatchEvent(new Event('input'));
        document.getElementById('password').dispatchEvent(new Event('input'));
        
        showNotification('Credentials filled! Click Sign In to login.', 'success');
      }

      // Show notification
      function showNotification(message, type = 'info') {
        const toast = document.getElementById('toast');
        const icon = document.getElementById('toastIcon');
        const messageEl = document.getElementById('toastMessage');
        
        toast.className = `toast ${type}`;
        messageEl.textContent = message;
        
        switch(type) {
          case 'success':
            icon.className = 'fas fa-check-circle';
            break;
          case 'error':
            icon.className = 'fas fa-exclamation-circle';
            break;
          default:
            icon.className = 'fas fa-info-circle';
        }
        
        toast.classList.add('show');
        setTimeout(() => {
          toast.classList.remove('show');
        }, 4000);
      }

      // Placeholder functions for demo
      function showForgotPassword() {
        showNotification('Forgot password feature coming soon!', 'info');
      }

      function showSignupInfo() {
        showNotification('Signup feature coming soon! Use demo credentials for now.', 'info');
      }

      function showHelp() {
        showNotification('Help: Use demo credentials above to login.', 'info');
      }

      function showPrivacy() {
        showNotification('Privacy policy coming soon!', 'info');
      }

      // Form submission with loading state
      document.getElementById('loginForm').addEventListener('submit', function(e) {
        const loginBtn = document.getElementById('loginBtn');
        loginBtn.classList.add('loading');
        
        // Remove loading state after a delay (form will submit)
        setTimeout(() => {
          loginBtn.classList.remove('loading');
        }, 3000);
      });

      // Focus management
      document.addEventListener('DOMContentLoaded', function() {
        // Focus first input
        document.getElementById('username').focus();
        
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
          if (e.key === 'Escape') {
            document.activeElement.blur();
          }
        });

        // Auto-fill animation trigger
        const inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
        inputs.forEach(input => {
          input.addEventListener('input', function() {
            // This helps with browser autofill detection
            if (this.value) {
              this.setAttribute('data-filled', 'true');
            } else {
              this.removeAttribute('data-filled');
            }
          });
        });

        // Welcome message
        setTimeout(() => {
          showNotification('Welcome! Use the demo credentials to get started.', 'info');
        }, 1000);
      });

      // Enhanced form validation
      function validateForm() {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        
        if (!username) {
          showNotification('Please enter your username.', 'error');
          document.getElementById('username').focus();
          return false;
        }
        
        if (!password) {
          showNotification('Please enter your password.', 'error');
          document.getElementById('password').focus();
          return false;
        }
        
        if (password.length < 6) {
          showNotification('Password must be at least 6 characters long.', 'error');
          document.getElementById('password').focus();
          return false;
        }
        
        return true;
      }

      // Add validation to form
      document.getElementById('loginForm').addEventListener('submit', function(e) {
        if (!validateForm()) {
          e.preventDefault();
          document.getElementById('loginBtn').classList.remove('loading');
        }
      });
    </script>
  </body>
</html>
