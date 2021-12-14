//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AgentsApp
{
    using System;
    using System.Collections.Generic;
    
    public partial class Agents
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Agents()
        {
            this.ProductSale = new HashSet<ProductSale>();
        }
    
        public long ID { get; set; }
        public long TypeID { get; set; }
        public string TypeName { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Logotype { get; set; }
        public string Address { get; set; }
        public Nullable<int> Priority { get; set; }
        public string Director { get; set; }
        public Nullable<double> INN { get; set; }
        public Nullable<double> KPP { get; set; }
    
        public virtual TypeOfAgents TypeOfAgents { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProductSale> ProductSale { get; set; }
    }
}
