using System;
using System.Linq;
using System.Windows;

namespace AgentsApp.Forms
{
    /// <summary>
    /// Логика взаимодействия для AddAgentForm.xaml
    /// </summary>
    public partial class AddAgentForm : Window
    {
        private Agents _newAgent;
        public AddAgentForm()
        {
            InitializeComponent();
            _newAgent = new Agents();
            DataContext = _newAgent;

            typeOfAgentComboBox.ItemsSource = user2Entities.GetContext().TypeOfAgents.ToList();
        }

        private void AcceptButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int priorityValue = 0;
                bool isPriorityParsed = int.TryParse(priorityTextBox.Text, out priorityValue);
                if (!isPriorityParsed)
                {
                    MessageBox.Show("Ошибка: приоритет должен быть целочисленным типом", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                int innValue = 0;
                bool isINNParsed = int.TryParse(innTextBox.Text, out innValue);
                if (!isINNParsed)
                {
                    MessageBox.Show("Ошибка: ИНН должен быть целочисленным типом", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                int kppValue = 0;
                bool isKPPParsed = int.TryParse(kppTextBox.Text, out kppValue);
                if (!isKPPParsed)
                {
                    MessageBox.Show("Ошибка: КПП должен быть целочисленным типом", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                user2Entities.GetContext().Agents.Add(_newAgent);
                DialogResult = true;
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
