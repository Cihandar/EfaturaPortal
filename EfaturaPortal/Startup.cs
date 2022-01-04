using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EfaturaPortal.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Razor.Compilation;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using System.Reflection;
using EfaturaPortal.Application.Infrastructure.AutoMapper;
using EfaturaPortal.Application.Interfaces.Firmalar;
using EfaturaPortal.Application.Firmalars.Commands;
using EfaturaPortal.Application.Interfaces.Cariler;
using EfaturaPortal.Application.Carilers.Commands;
using EfaturaPortal.Application.Interfaces.Auth;
using EfaturaPortal.Application.Auths.Command;
using EfaturaPortal.Application.Interfaces.Email;
using EfaturaPortal.Extentions;
using FluentValidation.AspNetCore;
using EfaturaPortal.Application.Interfaces.SeriNumaralars;
using EfaturaPortal.Application.SeriNumaralars.Commands;
using EfaturaPortal.Application.Interfaces.FileUploads;
using EfaturaPortal.Application.Faturas.Commands;
using EfaturaPortal.Application.Interfaces.Faturas;
using EfaturaPortal.Application.Interfaces.EfaturaApis;
using EfaturaPortal.Application.EfaturaApi.Command;
using EfaturaPortal.Application.EfaturaApi.Authorization;
using EdmEfatura;
using EfaturaPortal.Application.Interfaces.DovizKodlaris;
using EfaturaPortal.Application.DovizKodlaris.Commands;
using EfaturaPortal.Application.Interfaces.Extentions;

using EfaturaPortal.Application.Interfaces.FaturaSatirs;
using EfaturaPortal.Application.Interfaces.IstisnaKodlaris;
using EfaturaPortal.Application.Interfaces.TevkifatKodlaris;
using EfaturaPortal.Application.Interfaces.OlcuBirimleris;

using EfaturaPortal.Application.FaturaSatirs.Commands;
using EfaturaPortal.Application.IstisnaKodlaris.Commands;
using EfaturaPortal.Application.TevkifatKodlaris.Commands;
using EfaturaPortal.Application.OlcuBirimleris.Commands;
using EfaturaPortal.Application.Interfaces.Ulkelers;
using EfaturaPortal.Application.Ulkelers.Commands;
using EfaturaPortal.Application.Interfaces.VergiKodlaris;
using EfaturaPortal.Application.VergiKodlaris.Commands;
using EfaturaPortal.Application.Interfaces.FaturaSatirKdvlers;
using EfaturaPortal.Application.FaturaSatirKdvlers.Commands;
using EfaturaPortal.Application.Interfaces.OdemeTurleris;
using EfaturaPortal.Application.OdemeTurleris.Commands;
using Microsoft.AspNetCore.Localization;
using System.Globalization;
using Microsoft.Extensions.Options;

namespace EfaturaPortal
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            #region DbContext
            services.AddDbContext<EfaturaPortalContext>(options => options.UseSqlServer(Configuration.GetConnectionString("EfaturaPortalCon")));
            #endregion

            #region Application

            services.AddScoped<IAuthCrud, AuthCrud>();
            services.AddScoped<IFirmalarCrud, FirmalarCrud>();
            services.AddScoped<ICarilerCrud, CarilerCrud>();
            services.AddScoped<ISeriNumaralarCrud, SeriNumaralarCrud>();
            services.AddScoped<ISendEmail, SendEmail>();
            services.AddScoped<IFileUpload, FileUpload>();
            services.AddScoped<IFaturaCrud, FaturaCrud>();
            services.AddScoped<IDovizKodlariCrud, DovizKodlariCrud>();
            services.AddScoped<ITcmbDovizKurlari, TcmbDovizKurlari>();
            services.AddScoped<IOlcuBirimleriCrud, OlcuBirimleriCrud>();
            services.AddScoped<ITevkifatKodlariCrud, TevkifatKodlariCrud>();
            services.AddScoped<IVergiKodlariCrud, VergiKodlariCrud>();
            services.AddScoped<IIstisnaKodlariCrud, IstisnaKodlariCrud>();
            services.AddScoped<IFaturaSatirCrud, FaturaSatirCrud>();
            services.AddScoped<IFaturaSatirKdvlerCrud, FaturaSatirKdvlerCrud>();
            services.AddScoped<IUlkelerCrud, UlkelerCrud>();

            services.AddScoped<IOdemeTurleriCrud, OdemeTurleriCrud>();

            services.AddScoped<IEInvoiceTransactions, EInvoiceTransactions>();
            services.AddScoped<IEdmEInvoiceLogin, EdmEInvoiceLogin>();
            services.AddScoped<EFaturaEDMPortClient, EFaturaEDMPortClient>();
            #endregion


            services.Configure<RequestLocalizationOptions>(opts => { var supportedCultures = new List<CultureInfo> { new CultureInfo("tr"), new CultureInfo("en"), }; opts.DefaultRequestCulture = new RequestCulture("tr"); opts.SupportedCultures = supportedCultures; opts.SupportedUICultures = supportedCultures; opts.SetDefaultCulture("tr"); });

            //AutoMapper

            services.AddAutoMapper(new Assembly[] { typeof(AutoMapperProfile).GetTypeInfo().Assembly });

            services.AddIdentity<AppUser, IdentityRole>(options =>
            {
                options.Password.RequiredLength = 2;
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireLowercase = false;
                options.Password.RequireUppercase = false;
                options.Password.RequireDigit = false;
                options.Password.RequiredUniqueChars = 0;
                options.Lockout = new LockoutOptions { AllowedForNewUsers = false };
                options.Tokens.PasswordResetTokenProvider = TokenOptions.DefaultEmailProvider;
            })
    .AddEntityFrameworkStores<EfaturaPortalContext>()
    .AddDefaultTokenProviders();

            services.Configure<SecurityStampValidatorOptions>(options =>
            {
                options.ValidationInterval = TimeSpan.Zero;
            });

            services.ConfigureApplicationCookie(options =>
            {
                options.Cookie.HttpOnly = true;
                options.ExpireTimeSpan = TimeSpan.FromHours(24);
                options.LoginPath = "/Auth/Login";
                options.LogoutPath = "/Auth/Logout";
                options.AccessDeniedPath = "/Auth/AccessDenied";
                options.Cookie = new CookieBuilder
                {
                    IsEssential = true, // required for auth to work without explicit user consent; adjust to suit your privacy policy,
                    Name = ".EfaturaPortal.Session",
                    HttpOnly = false,
                    SecurePolicy = CookieSecurePolicy.Always
                };

            });

            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(20);
                options.Cookie.HttpOnly = false;
                options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
                options.Cookie.Name = ".EfaturaPortal.Session";
            });

            services.AddControllersWithViews().AddFluentValidation(x => x.RegisterValidatorsFromAssemblyContaining<Startup>());

       //    services.AddControllersWithViews().AddRazorRuntimeCompilation();

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_3_0);

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        [Obsolete]
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }


            app.UseRequestLocalization(new RequestLocalizationOptions
            {
                DefaultRequestCulture = new RequestCulture("en-US")
            }); 

            //var options = app.ApplicationServices.GetService<IOptions<RequestLocalizationOptions>>();

            //app.UseRequestLocalization(options.Value);

            app.UseRouting();
            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseCookiePolicy();
            app.UseAuthentication();
            app.UseAuthorization();

 

            #region Routing
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "usernotfound",
                    pattern: "/usernotfound",
                    defaults: new { controller = "Error", action = "UserNotFound" });

                endpoints.MapControllerRoute(
                    name: "notfound",
                    pattern: "/notfound",
                    defaults: new { controller = "Error", action = "NotFound" });

                endpoints.MapControllerRoute(
                    name: "unauthorized",
                    pattern: "/unauthorized",
                    defaults: new { controller = "Auth", action = "Unauthorized" });

                endpoints.MapControllerRoute(
                    name: "authentication",
                    pattern: "/authentication",
                    defaults: new { controller = "Auth", action = "Login" });

                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
            #endregion
        }
    }
}
