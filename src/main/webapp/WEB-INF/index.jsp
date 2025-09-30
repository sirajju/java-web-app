<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">
  <jsp:include page="./component/header.jsp" />
  <body>
    <!-- Navigation Header -->
    <nav class="navbar">
      <div class="nav-container">
        <div class="nav-brand">
          <i class="fas fa-code"></i>
          <span>Demo App</span>
        </div>
        <div class="nav-menu">
          <a href="${pageContext.request.contextPath}/test" class="nav-link">
            <i class="fas fa-flask"></i> Test Servlet
          </a>
          <a href="${pageContext.request.contextPath}/login?logout=true" class="nav-link logout">
            <i class="fas fa-sign-out-alt"></i> Logout
          </a>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
      <!-- Hero Section -->
      <div class="hero">
        <div class="hero-content">
          <h1 class="hero-title">${message}</h1>
          <p class="hero-subtitle">Manage your tasks and explore the application features</p>
          <div class="hero-stats">
            <div class="stat-card">
              <i class="fas fa-tasks"></i>
              <div>
                <span class="stat-number">${fn:length(todos)}</span>
                <span class="stat-label">Total Tasks</span>
              </div>
            </div>
            <div class="stat-card">
              <i class="fas fa-check-circle"></i>
              <div>
                <span class="stat-number" id="completedTasks">0</span>
                <span class="stat-label">Completed</span>
              </div>
            </div>
            <div class="stat-card">
              <i class="fas fa-clock"></i>
              <div>
                <span class="stat-number" id="currentTime">--:--</span>
                <span class="stat-label">Current Time</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Todo Section -->
      <div class="section">
        <div class="section-header">
          <h2><i class="fas fa-list-check"></i> Your Tasks</h2>
          <button class="btn btn-primary" onclick="addNewTask()">
            <i class="fas fa-plus"></i> Add Task
          </button>
        </div>
        
        <div class="todos-container" id="todosContainer">
          <c:choose>
            <c:when test="${not empty todos}">
              <c:forEach var="todo" items="${todos}" varStatus="status">
                <div class="todo-card" data-index="${status.index}">
                  <div class="todo-content">
                    <div class="todo-checkbox">
                      <input type="checkbox" id="todo-${status.index}" onchange="toggleTodo('${status.index}')">
                      <label for="todo-${status.index}"></label>
                    </div>
                    <div class="todo-text">
                      <h4 class="todo-title">${todo}</h4>
                    </div>
                  </div>
                  <div class="todo-actions">
                    <button class="btn-icon" onclick="editTodo('${status.index}')" title="Edit">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-icon delete" onclick="deleteTodo('${status.index}')" title="Delete">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <i class="fas fa-clipboard-list"></i>
                <h3>No tasks yet</h3>
                <p>Create your first task to get started!</p>
                <button class="btn btn-primary" onclick="addNewTask()">
                  <i class="fas fa-plus"></i> Create Task
                </button>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="section">
        <h2><i class="fas fa-bolt"></i> Quick Actions</h2>
        <div class="quick-actions">
          <div class="action-card" onclick="showNotification('Feature coming soon!', 'info')">
            <i class="fas fa-chart-bar"></i>
            <h3>Analytics</h3>
            <p>View your productivity stats</p>
          </div>
          <div class="action-card" onclick="exportTasks()">
            <i class="fas fa-download"></i>
            <h3>Export</h3>
            <p>Download your tasks</p>
          </div>
          <div class="action-card" onclick="showSettings()">
            <i class="fas fa-cog"></i>
            <h3>Settings</h3>
            <p>Customize your experience</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal for Adding/Editing Tasks -->
    <div id="taskModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 id="modalTitle">Add New Task</h3>
          <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
          <form id="taskForm">
            <div class="form-group">
              <label for="taskTitle">Task Title</label>
              <input type="text" id="taskTitle" required placeholder="Enter your task...">
            </div>
            <div class="form-actions">
              <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
              <button type="submit" class="btn btn-primary">Save Task</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Notification Toast -->
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
        color: #333;
      }

      /* Navigation */
      .navbar {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
      }

      .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .nav-brand {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 700;
        font-size: 1.5rem;
        color: #667eea;
      }

      .nav-menu {
        display: flex;
        gap: 2rem;
      }

      .nav-link {
        color: #666;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border-radius: 8px;
        transition: all 0.3s ease;
      }

      .nav-link:hover {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
        transform: translateY(-2px);
      }

      .nav-link.logout:hover {
        background: rgba(239, 68, 68, 0.1);
        color: #ef4444;
      }

      /* Container */
      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
      }

      /* Hero Section */
      .hero {
        text-align: center;
        margin-bottom: 3rem;
      }

      .hero-content {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 3rem;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
      }

      .hero-title {
        font-size: 3rem;
        font-weight: 700;
        background: linear-gradient(135deg, #667eea, #764ba2);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 1rem;
      }

      .hero-subtitle {
        font-size: 1.2rem;
        color: #666;
        margin-bottom: 2rem;
      }

      .hero-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
      }

      .stat-card {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1.5rem;
        background: rgba(255, 255, 255, 0.7);
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s ease;
      }

      .stat-card:hover {
        transform: translateY(-5px);
      }

      .stat-card i {
        font-size: 2rem;
        color: #667eea;
      }

      .stat-number {
        display: block;
        font-size: 2rem;
        font-weight: 700;
        color: #333;
      }

      .stat-label {
        color: #666;
        font-size: 0.9rem;
      }

      /* Sections */
      .section {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 2rem;
        margin-bottom: 2rem;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
      }

      .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
      }

      .section h2 {
        font-size: 1.8rem;
        font-weight: 600;
        color: #333;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      /* Buttons */
      .btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
        text-decoration: none;
      }

      .btn-primary {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
      }

      .btn-secondary {
        background: #f1f5f9;
        color: #64748b;
      }

      .btn-secondary:hover {
        background: #e2e8f0;
      }

      .btn-icon {
        background: none;
        border: none;
        cursor: pointer;
        padding: 0.5rem;
        border-radius: 8px;
        color: #666;
        transition: all 0.3s ease;
      }

      .btn-icon:hover {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
      }

      .btn-icon.delete:hover {
        background: rgba(239, 68, 68, 0.1);
        color: #ef4444;
      }

      /* Todo Cards */
      .todos-container {
        display: grid;
        gap: 1rem;
      }

      .todo-card {
        background: rgba(255, 255, 255, 0.8);
        border-radius: 15px;
        padding: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border-left: 4px solid #667eea;
      }

      .todo-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      }

      .todo-card.completed {
        opacity: 0.7;
        border-left-color: #10b981;
      }

      .todo-content {
        display: flex;
        align-items: flex-start;
        gap: 1rem;
        flex: 1;
      }

      .todo-checkbox {
        position: relative;
      }

      .todo-checkbox input[type="checkbox"] {
        appearance: none;
        width: 20px;
        height: 20px;
        border: 2px solid #667eea;
        border-radius: 4px;
        position: relative;
        cursor: pointer;
      }

      .todo-checkbox input[type="checkbox"]:checked {
        background: #667eea;
      }

      .todo-checkbox input[type="checkbox"]:checked::after {
        content: "✓";
        position: absolute;
        top: -2px;
        left: 3px;
        color: white;
        font-size: 14px;
      }

      .todo-text {
        flex: 1;
      }

      .todo-title {
        font-size: 1.1rem;
        font-weight: 600;
        color: #333;
        margin-bottom: 0.5rem;
      }

      .todo-description {
        color: #666;
        font-size: 0.9rem;
        line-height: 1.4;
      }

      .todo-actions {
        display: flex;
        gap: 0.5rem;
      }

      /* Empty State */
      .empty-state {
        text-align: center;
        padding: 3rem;
        color: #666;
      }

      .empty-state i {
        font-size: 4rem;
        color: #ccc;
        margin-bottom: 1rem;
      }

      .empty-state h3 {
        margin-bottom: 0.5rem;
      }

      .empty-state p {
        margin-bottom: 2rem;
      }

      /* Quick Actions */
      .quick-actions {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
      }

      .action-card {
        background: rgba(255, 255, 255, 0.7);
        border-radius: 15px;
        padding: 2rem;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
      }

      .action-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      }

      .action-card i {
        font-size: 3rem;
        color: #667eea;
        margin-bottom: 1rem;
      }

      .action-card h3 {
        margin-bottom: 0.5rem;
        color: #333;
      }

      .action-card p {
        color: #666;
        font-size: 0.9rem;
      }

      /* Modal */
      .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(5px);
        z-index: 1000;
        justify-content: center;
        align-items: center;
      }

      .modal-content {
        background: white;
        border-radius: 20px;
        width: 90%;
        max-width: 500px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
      }

      .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 2rem 2rem 1rem;
        border-bottom: 1px solid #eee;
      }

      .modal-header h3 {
        font-size: 1.5rem;
        font-weight: 600;
      }

      .modal-close {
        background: none;
        border: none;
        font-size: 2rem;
        cursor: pointer;
        color: #666;
        line-height: 1;
      }

      .modal-body {
        padding: 2rem;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #333;
      }

      .form-group input,
      .form-group textarea {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
      }

      .form-group input:focus,
      .form-group textarea:focus {
        outline: none;
        border-color: #667eea;
      }

      .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
        margin-top: 2rem;
      }

      /* Toast Notification */
      .toast {
        position: fixed;
        top: 2rem;
        right: 2rem;
        background: white;
        border-radius: 10px;
        padding: 1rem 1.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        transform: translateX(400px);
        transition: transform 0.3s ease;
        z-index: 1001;
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
        }

        .hero-title {
          font-size: 2rem;
        }

        .nav-container {
          padding: 1rem;
        }

        .nav-menu {
          gap: 1rem;
        }

        .hero-stats {
          grid-template-columns: 1fr;
        }

        .section-header {
          flex-direction: column;
          gap: 1rem;
          align-items: flex-start;
        }

        .quick-actions {
          grid-template-columns: 1fr;
        }
      }

      /* Animations */
      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .todo-card {
        animation: fadeIn 0.3s ease;
      }
    </style>

    <script>
      let editingIndex = -1;

      // Update time every second
      function updateTime() {
        const now = new Date();
        const timeString = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        document.getElementById('currentTime').textContent = timeString;
      }

      // Update completed tasks count
      function updateCompletedCount() {
        const completed = document.querySelectorAll('.todo-card input[type="checkbox"]:checked').length;
        document.getElementById('completedTasks').textContent = completed;
      }

      // Toggle todo completion
      function toggleTodo(index) {
        const todoCard = document.querySelector(`[data-index="${index}"]`);
        const checkbox = todoCard.querySelector('input[type="checkbox"]');
        
        if (checkbox.checked) {
          todoCard.classList.add('completed');
        } else {
          todoCard.classList.remove('completed');
        }
        
        updateCompletedCount();
        showNotification(checkbox.checked ? 'Task completed!' : 'Task uncompleted!', 'success');
      }

      // Add new task
      function addNewTask() {
        editingIndex = -1;
        document.getElementById('modalTitle').textContent = 'Add New Task';
        document.getElementById('taskTitle').value = '';
        document.getElementById('taskModal').style.display = 'flex';
        document.getElementById('taskTitle').focus();
      }

      // Edit task
      function editTodo(index) {
        editingIndex = index;
        const todoCard = document.querySelector(`[data-index="${index}"]`);
        const title = todoCard.querySelector('.todo-title').textContent;
        
        document.getElementById('modalTitle').textContent = 'Edit Task';
        document.getElementById('taskTitle').value = title;
        document.getElementById('taskModal').style.display = 'flex';
        document.getElementById('taskTitle').focus();
      }

      // Delete task
      function deleteTodo(index) {
        if (confirm('Are you sure you want to delete this task?')) {
          const todoCard = document.querySelector(`[data-index="${index}"]`);
          todoCard.style.animation = 'fadeOut 0.3s ease';
          setTimeout(() => {
            todoCard.remove();
            updateCompletedCount();
            showNotification('Task deleted!', 'success');
          }, 300);
        }
      }

      // Close modal
      function closeModal() {
        document.getElementById('taskModal').style.display = 'none';
        editingIndex = -1;
      }

      // Handle task form submission
      document.getElementById('taskForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const title = document.getElementById('taskTitle').value.trim();
        
        if (!title) {
          showNotification('Please enter a task title!', 'error');
          return;
        }

        if (editingIndex >= 0) {
          // Edit existing task
          const todoCard = document.querySelector(`[data-index="${editingIndex}"]`);
          todoCard.querySelector('.todo-title').textContent = title;
          showNotification('Task updated!', 'success');
        } else {
          // Add new task
          const todosContainer = document.getElementById('todosContainer');
          const newIndex = document.querySelectorAll('.todo-card').length;
          
          const todoCard = document.createElement('div');
          todoCard.className = 'todo-card';
          todoCard.setAttribute('data-index', newIndex);
          todoCard.innerHTML = `
            <div class="todo-content">
              <div class="todo-checkbox">
                <input type="checkbox" id="todo-${newIndex}" onchange="toggleTodo(${newIndex})">
                <label for="todo-${newIndex}"></label>
              </div>
              <div class="todo-text">
                <h4 class="todo-title">${title}</h4>
              </div>
            </div>
            <div class="todo-actions">
              <button class="btn-icon" onclick="editTodo(${newIndex})" title="Edit">
                <i class="fas fa-edit"></i>
              </button>
              <button class="btn-icon delete" onclick="deleteTodo(${newIndex})" title="Delete">
                <i class="fas fa-trash"></i>
              </button>
            </div>
          `;
          
          // Remove empty state if exists
          const emptyState = todosContainer.querySelector('.empty-state');
          if (emptyState) {
            emptyState.remove();
          }
          
          todosContainer.appendChild(todoCard);
          showNotification('Task added!', 'success');
        }
        
        closeModal();
      });

      // Export tasks
      function exportTasks() {
        const tasks = Array.from(document.querySelectorAll('.todo-card')).map(card => {
          const title = card.querySelector('.todo-title').textContent;
          const completed = card.querySelector('input[type="checkbox"]').checked;
          return { title, completed };
        });
        
        const dataStr = JSON.stringify(tasks, null, 2);
        const dataBlob = new Blob([dataStr], {type: 'application/json'});
        
        const link = document.createElement('a');
        link.href = URL.createObjectURL(dataBlob);
        link.download = 'tasks.json';
        link.click();
        
        showNotification('Tasks exported!', 'success');
      }

      // Show settings (placeholder)
      function showSettings() {
        showNotification('Settings panel coming soon!', 'info');
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
        }, 3000);
      }

      // Close modal when clicking outside
      document.getElementById('taskModal').addEventListener('click', function(e) {
        if (e.target === this) {
          closeModal();
        }
      });

      // Keyboard shortcuts
      document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
          closeModal();
        }
        if (e.ctrlKey && e.key === 'k') {
          e.preventDefault();
          addNewTask();
        }
      });

      // Initialize
      document.addEventListener('DOMContentLoaded', function() {
        updateTime();
        setInterval(updateTime, 1000);
        updateCompletedCount();
        
        // Add fade-in animation to page elements
        const elements = document.querySelectorAll('.hero, .section');
        elements.forEach((el, index) => {
          el.style.animation = `fadeIn 0.6s ease ${index * 0.1}s both`;
        });
      });

      // Add fadeOut animation
      const style = document.createElement('style');
      style.textContent = `
        @keyframes fadeOut {
          from {
            opacity: 1;
            transform: translateY(0);
          }
          to {
            opacity: 0;
            transform: translateY(-20px);
          }
        }
      `;
      document.head.appendChild(style);
    </script>
  </body>
</html>
