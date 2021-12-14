using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace AgentsApp.Pages
{
    /// <summary>
    /// Логика взаимодействия для MainPage.xaml
    /// </summary>
    public partial class MainPage : Page
    {
        private const int MAX_AGENTS_COUNT = 10;

        private int _currentPageIndex = 0;
        private int _pagesCount = 0;

        public MainPage()
        {
            InitializeComponent();
            try
            {
                var agents = user2Entities.GetContext().Agents.ToList();
                for (int i = 0; i < agents.Count; i++)
                {
                    if (agents[i].Logotype == null || agents[i].Logotype == "")
                    {
                        agents[i].Logotype = "/picture.png";
                    }
                }
                UpdatePaginatedList(agents);

                previousButton.Content = "<";
                nextButton.Content = ">";

                var typeOfAgentFilters = user2Entities.GetContext().TypeOfAgents.ToList();
                typeOfAgentFilters.Insert(0, new TypeOfAgents()
                {
                    Name = "Все типы",
                });
                filterComboBox.ItemsSource = typeOfAgentFilters;
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void pageButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Button pageButton = sender as Button;
                _currentPageIndex = Convert.ToInt32(pageButton.Content) - 1;
                var agents = user2Entities.GetContext().Agents.ToList();
                UpdatePaginatedList(agents);
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void PreviousButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                nextButton.IsEnabled = true;
                if (_currentPageIndex > 0)
                {
                    previousButton.IsEnabled = true;
                    _currentPageIndex--;

                    var agents = user2Entities.GetContext().Agents.ToList();
                    UpdatePaginatedList(agents);
                }
                else
                {
                    previousButton.IsEnabled = false;
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void NextButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                previousButton.IsEnabled = true;
                if (_currentPageIndex < _pagesCount - 1)
                {
                    nextButton.IsEnabled = true;
                    _currentPageIndex++;

                    var agents = user2Entities.GetContext().Agents.ToList();
                    UpdatePaginatedList(agents);
                }
                else
                {
                    nextButton.IsEnabled = false;
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            try
            {
                if (searchTextBox.Text != "")
                {
                    var agents = user2Entities.GetContext().Agents
                        .Where(
                            agent => (agent.Name + agent.Email + agent.Phone).ToLower().Contains(searchTextBox.Text.ToLower())
                        ).ToList();
                    UpdatePaginatedList(agents);
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SorterComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                if ((sorterComboBox.SelectedItem as ComboBoxItem).Content as string == "По возрастанию")
                {
                    var agents = user2Entities.GetContext().Agents.OrderBy(agent => agent.Priority).ToList();
                    UpdatePaginatedList(agents);
                }
                else if ((sorterComboBox.SelectedItem as ComboBoxItem).Content as string == "По убыванию")
                {
                    var agents = user2Entities.GetContext().Agents.OrderByDescending(agent => agent.Priority).ToList();
                    UpdatePaginatedList(agents);
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void FilterComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                var typeID = (filterComboBox.SelectedItem as TypeOfAgents).ID;
                var agents = user2Entities.GetContext().Agents
                    .Where(
                        agent =>
                        agent.TypeID == typeID
                    ).ToList();
                UpdatePaginatedList(agents);
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void UpdatePaginatedList(List<Agents> agents)
        {
            _pagesCount = (int)Math.Round(Convert.ToDouble(agents.Count / MAX_AGENTS_COUNT));
            paginationPanel.Children.Clear();

            for (int i = 0; i < _pagesCount; i++)
            {
                Button pageButton = new Button()
                {
                    Content = $"{i + 1}",
                    Width = 20,
                    Height = 20,
                    Background = System.Windows.Media.Brushes.Transparent,
                    BorderBrush = System.Windows.Media.Brushes.Transparent,
                    Margin = new Thickness(5, 0, 5, 0),
                };
                pageButton.Click += pageButton_Click;
                paginationPanel.Children.Add(pageButton);
            }

            if (_pagesCount > 0)
            {
                agentsList.ItemsSource = agents.GetRange(_currentPageIndex * MAX_AGENTS_COUNT, MAX_AGENTS_COUNT);
            }
            else
            {
                agentsList.ItemsSource = agents;
            }
        }

        private void AddAgentButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Forms.AddAgentForm form = new Forms.AddAgentForm();
                if (form.ShowDialog() == true)
                {
                    user2Entities.GetContext().SaveChanges();
                }

                var agents = user2Entities.GetContext().Agents.ToList();
                UpdatePaginatedList(agents);
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void EditAgentButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (agentsList.SelectedItem != null)
                {
                    var agent = agentsList.SelectedItem as Agents;
                    Forms.EditAgentForm form = new Forms.EditAgentForm(agent);
                    if (form.ShowDialog() == true)
                    {
                        user2Entities.GetContext().SaveChanges();
                    }

                    var agents = user2Entities.GetContext().Agents.ToList();
                    UpdatePaginatedList(agents);
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show($"Ошибка: {exc.Message}", "Session 2", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
