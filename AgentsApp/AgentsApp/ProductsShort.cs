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
    
    public partial class ProductsShort
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProductsShort()
        {
            this.ProductSale = new HashSet<ProductSale>();
        }
    
        public long ID { get; set; }
        public string Name { get; set; }
        public long TypeID { get; set; }
        public string TypeName { get; set; }
        public Nullable<double> Article { get; set; }
        public Nullable<double> CountOfPeople { get; set; }
        public Nullable<double> FactoryNumber { get; set; }
        public Nullable<decimal> MinPrice { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProductSale> ProductSale { get; set; }
        public virtual TypeOfProducts TypeOfProducts { get; set; }
    }
}
