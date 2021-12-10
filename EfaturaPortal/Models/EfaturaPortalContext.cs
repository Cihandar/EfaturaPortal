using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EfaturaPortal.Models
{
    //TODO:Context Klasorunu ayri tutalim , diger modellerden farkli bir klasorde olsun
    //TODO:datalari eklerken basemodel içerisindeki firmaId contextsavechange aninda kayit edilebilir KONUSULACAK
    public class EfaturaPortalContext : IdentityDbContext<AppUser>
    {

        public EfaturaPortalContext(DbContextOptions<EfaturaPortalContext> options) : base(options) { }
        public EfaturaPortalContext()
        {



        }

        public DbSet<Cariler> Carilers { get; set; }
        public DbSet<Fatura> Faturas { get; set; }
        public DbSet<FaturaSatir> FaturaSatirs { get; set; }
        public DbSet<Firmalar> Firmalars { get; set; }
        public DbSet<SeriNumaralar> SeriNumaralars { get; set; }

        public DbSet<DovizKodlari> DovizKodlaris { get; set; }

        //public DbSet<ParaBirimleri> ParaBirimleris { get; set; }
        public DbSet<OlcuBirimleri> OlcuBirimleris { get; set; }
        public DbSet<IstisnaKodlari> IstisnaKodlaris { get; set; }
        public DbSet<TevkifatKodlari> TevkifatKodlaris { get; set; }
        public DbSet<Ulkeler> Ulkelers { get; set; }

        public DbSet<VergiKodlari> VergiKodlaris { get; set; }


    }
}