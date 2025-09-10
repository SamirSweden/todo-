var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.Services.AddBlazoredLocalStorageAsSingleton();
await builder.Build().RunAsync();



@page "/calc"
@using System.IO
@using Blazored.LocalStorage
@inject ILocalStorageService LocalStorage

<h3>Simple Calculator</h3>

<input type="number" @bind="Number1" />
<input type="number" @bind="Number2" />

<button @onclick="() => Calculate('+')">+</button>
<button @onclick="() => Calculate('-')">-</button>
<button @onclick="() => Calculate('*')">*</button>
<button @onclick="() => Calculate('/')">/</button>

<ul>
    @foreach (var r in StoredResults)
    {
        <li>@r</li>
    }
</ul>

<hr />


<h3>File Editor</h3>

@if (Files == null)
{
    <p>Loading files...</p>
}
else
{
    <ul>
        @foreach (var file in Files)
        {
            <li>
                <a href="#" @onclick="() => LoadFile(file)">@file</a>
            </li>
        }
    </ul>

    @if (SelectedFile != null)
    {
        <h4>Editing: @SelectedFile</h4>

        <textarea rows="15" cols="70" @bind="FileContent"></textarea>
        <br />
        <button @onclick="SaveFile">Save</button>

        @if (!string.IsNullOrEmpty(Message))
        {
            <p style="color:green">@Message</p>
        }
    }
}

@code {
    double Number1 { get; set; }
    double Number2 { get; set; }
    List<string> StoredResults { get; set; } = new();

    async Task Calculate(char op)
    {
        string resultText;
        double result = 0;

        try
        {
            switch (op)
            {
                case '+':
                    result = Number1 + Number2;
                    break;
                case '-':
                    result = Number1 - Number2;
                    break;
                case '*':
                    result = Number1 * Number2;
                    break;
                case '/':
                    if (Number2 == 0)
                        throw new DivideByZeroException();
                    result = (double)Number1 / Number2;
                    break;
                default:
                    throw new InvalidOperationException("Unknown operation");
            }

            resultText = $"{Number1} {op} {Number2} = {result}";
        }
        catch (Exception ex)
        {
            resultText = $"Error: {ex.Message}";
        }
        StoredResults.Add(resultText);
        await LocalStorage.SetItemAsync<List<string>>("data",StoredResults);

    }

    List<string>? Files;
    string? SelectedFile;
    string? FileContent;
    string? Message;

    string _filesPath = ""; 

    protected override async Task OnInitializedAsync()
    {
        var list = await LocalStorage.GetItemAsync<List<string>>("data");
        if (list != null)
            StoredResults = list;

        Files = new List<string> { "example1.txt", "example2.txt" };

        _fakeFileContents = new Dictionary<string, string>
            {
                ["example1.txt"] = "Hello from example1!",
                ["example2.txt"] = "This is example2 file content."
            };
    }

    Dictionary<string, string> _fakeFileContents = new();

    async Task LoadFile(string file)
    {
        SelectedFile = file;
        Message = null;
        if (_fakeFileContents.TryGetValue(file, out var content))
        {
            FileContent = content;
        }
        else
        {
            FileContent = "[File not found]";
        }
        await InvokeAsync(StateHasChanged);
    }

    async Task SaveFile()
    {
        if (SelectedFile != null)
        {
            _fakeFileContents[SelectedFile] = FileContent ?? "";
            Message = $"File '{SelectedFile}' saved successfully.";
        }
        await InvokeAsync(StateHasChanged);
    }
}



<div class="nav-item px-3">
    <NavLink class="nav-link" href="calc">
        <span class="bi bi-plus-square-fill-nav-menu" aria-hidden="true"></span> Calculator
    </NavLink>
</div>
This paste expires in <30 min. Public IP access. Share whatever you see with others in seconds with Context.Terms of ServiceReport this
