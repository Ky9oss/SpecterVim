using FlaUI.Core.AutomationElements;
using FlaUI.Core.Tools;
using FlaUI.UIA3;

class Program
{
  static void Main()
  {
    var app = FlaUI.Core.Application.Launch("notepad.exe");

    System.Threading.Thread.Sleep(1500);

    using (var automation = new UIA3Automation())
    {
      var window = Retry
        .WhileNull(
          () => automation.GetDesktop().FindFirstChild(cf => cf.ByClassName("Notepad"))?.AsWindow(),
          TimeSpan.FromSeconds(8),
          TimeSpan.FromMilliseconds(200)
        )
        .Result;

      if (window != null)
      {
        Console.WriteLine("Windows Title: " + window.Title);
      }
      else
      {
        Console.WriteLine("Not Found!");
      }
    }
  }
}
