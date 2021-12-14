using System;
using System.Linq;
using System.Windows;

namespace AgentsApp.Forms
{
    /// <summary>
    /// Логика взаимодействия для EditAgentForm.xaml
    /// </summary>
    public partial class EditAgentForm : Window
    {
        private Agents _selectedAgent;

        public EditAgentForm(Agents agent)
        {
            InitializeComponent();
            if (agent != null)
            {
                _selectedAgent = agent;
                DataContext = _selectedAgent;
                typeOfAgentComboBox.ItemsSource = user2Entities.GetContext().TypeOfAgents.ToList();
            }
            else
            {
                MessageBox.Show("Ошибка: агент не был выделен", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                DialogResult = false;
            }
        }

        private void DeleteAgentButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (_selectedAgent != null)
                {
                    user2Entities.GetContext().Agents.Remove(_selectedAgent);
                    MessageBox.Show("Агент удалён!", "Session 2", MessageBoxButton.OK, MessageBoxImage.Information);
                    DialogResult = true;
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void AcceptButton_Click(object sender, RoutedEventArgs e)
        {
            int priorityValue = 0;
            bool isPriorityParsed = int.TryParse(priorityTextBox.Text, out priorityValue);
            if (!isPriorityParsed)
            {
                MessageBox.Show("Ошибка: приоритет должен быть целочисленным типом", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            double innValue = 0;
            bool isINNParsed = double.TryParse(innTextBox.Text, out innValue);
            if (!isINNParsed)
            {
                MessageBox.Show("Ошибка: ИНН должен быть целочисленным типом", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            double kppValue = 0;
            bool isKPPParsed = double.TryParse(kppTextBox.Text, out kppValue);
            if (!isKPPParsed)
            {
                MessageBox.Show("Ошибка: КПП должен быть целочисленным типом", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            DialogResult = true;
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
