const API_BASE = '/api/todos';

const form = document.getElementById('todo-form');
const input = document.getElementById('todo-input');
const list = document.getElementById('todo-list');

async function loadTodos() {
  const res = await fetch(API_BASE);
  const todos = await res.json();
  list.innerHTML = '';
  todos.forEach(renderTodo);
}

function renderTodo(todo) {
  const li = document.createElement('li');
  if (todo.done) li.classList.add('done');

  const span = document.createElement('span');
  span.textContent = todo.title;
  span.onclick = () => toggleTodo(todo);

  const del = document.createElement('button');
  del.textContent = '✕';
  del.className = 'delete-btn';
  del.onclick = () => deleteTodo(todo.id);

  li.appendChild(span);
  li.appendChild(del);
  list.appendChild(li);
}

async function toggleTodo(todo) {
  await fetch(`${API_BASE}/${todo.id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ done: !todo.done }),
  });
  loadTodos();
}

async function deleteTodo(id) {
  await fetch(`${API_BASE}/${id}`, { method: 'DELETE' });
  loadTodos();
}

form.addEventListener('submit', async (e) => {
  e.preventDefault();
  const title = input.value.trim();
  if (!title) return;
  await fetch(API_BASE, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ title }),
  });
  input.value = '';
  loadTodos();
});

loadTodos();