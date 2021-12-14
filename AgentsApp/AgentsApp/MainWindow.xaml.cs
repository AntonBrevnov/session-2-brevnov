using System.Windows;
using System.Windows.Controls;

namespace AgentsApp
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static Frame MainFrame { get; set; }
        public MainWindow()
        {
            InitializeComponent();
            MainFrame = new Frame();
            Content = MainFrame;
            MainFrame.Navigate(new Pages.MainPage());
        }
    }
}
