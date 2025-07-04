using Bunit;
using WhiskyFrontend.Components.Pages;
using Xunit;
using Microsoft.Extensions.DependencyInjection;

namespace WhiskyFrontend.Tests;

public class NotesPageTest : TestContext
{
    [Fact]
    public void Notes_Page_Renders()
    {
        Services.AddHttpClient("NotesAPI", c => c.BaseAddress = new System.Uri("http://localhost"));
        var cut = RenderComponent<Notes>();
        Assert.Contains("Tasting Notes", cut.Markup);
    }
}
