namespace AgentsApp
{
    public partial class user2Entities
    {
        private static user2Entities _context;

        public static user2Entities GetContext()
        {
            if (_context == null)
                _context = new user2Entities();
            return _context;
        }
    }
}
