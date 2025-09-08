using Microsoft.AspNetCore.Mvc;
using MyApp.Models;



namespace MyApp.Controllers
{
    [ApiController]
    [Route("api/{controller}")]

    public class TodoController : ControllerBase
    {
        private static readonly List<TodoItem> Todos = new();
        private static int _nextId = 1;


        [HttpGet]
        public ActionResult<IEnumerable<TodoItem>> GetAll() => Todos;

        [HttpGet("{id}")]
        public ActionResult<TodoItem> GetById(int id)
        {
            var todo = Todos.FirstOrDefault(t => t.Id == id);
            return todo is null ? NotFound() : todo;
        }

        [HttpPost]
        public ActionResult<TodoItem> Create(TodoItem todo)
        {
            todo.Id = _nextId++;
            Todos.Add(todo);
            return CreatedAtAction(nameof(GetById), new { id = todo.Id }, todo);
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, TodoItem updated)
        {
            var todo = Todos.FirstOrDefault(t => t.Id == id);
            todo.Title = updated.Title;
            todo.IsDone = updated.IsDone;

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            var todo = Todos.FirstOrDefault(t => t.Id == id);
            if (todo == null) return NotFound();

            Todos.Remove(todo);
            return NoContent();
        }
    }
}






