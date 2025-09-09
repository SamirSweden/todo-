using Microsoft.AspNetCore.Mvc;
using WebAppApiCs.Models;
using System.IO;
using Newtonsoft.Json;
using System.Text.Json.Serialization;

namespace WebAppApiCs.Controllers
{
    [ApiController]
    [Route("api/[controller]")]

    public class HostController : ControllerBase
    {
        public const int StatusCode200 = 200;
        private const string FileName = "logs.txt";
        [HttpPost("CreateNew")]
        public IActionResult CreateCheck(Methods checkHost)
        {
            //SaveLogs(checkHost);
             this.HttpContext.Response.StatusCode = 200;
            return NoContent();
        }

        //private void SaveLogs(CheckHost checkHost)
        //{
        //    var list = new List<CheckHost>();
        //    if (System.IO.File.Exists(FileName))
        //    {
        //        var listStr = System.IO.File.ReadAllText(FileName);
        //        list = JsonConvert.DeserializeObject<List<CheckHost>>(listStr);
        //    }
        //    list.Add(checkHost);
        //    var str = JsonConvert.SerializeObject(list);

        //    System.IO.File.WriteAllText(FileName,str);
        //}


        [HttpGet("GetRequest")]
        public IActionResult HttpGetRequest(Methods check)
        {
            GetR(check);
            return Ok("GET request successfully made");
        }

        private void GetR(Methods check)
        {
            System.Net.Http.HttpClient client = new System.Net.Http.HttpClient();
            client.GetAsync("https://jsonplaceholder.typicode.com");
        }
    }

  
}

// Products  - class  -> 4 methods 
// ProductDetails - model

// post 
//get 
//put 
//delete 
