
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Linq;

using EfaturaPortal.Application.Interfaces.Mapping;

namespace EfaturaPortal.Application.Infrastructure.AutoMapper
{
    public sealed class Map
    {
        public Type Source { get; set; }

        public Type Destination { get; set; }
    }

    public static class MapperProfileHelper
    {
        public static IList<Map> LoadStandardMappings(Assembly rootAssembly)
        {
            var types = rootAssembly.GetExportedTypes();

            var mapsFrom = (from type in types
                            from instanse in type.GetInterfaces()
                            where
                                 instanse.IsGenericType && instanse.GetGenericTypeDefinition() == typeof(IMapFrom<>) &&
                                 !type.IsAbstract &&
                                 !type.IsInterface
                            select new Map
                            {
                                Source = type.GetInterfaces().First().GetGenericArguments().First(),
                                Destination = type
                            }).ToList();

            return mapsFrom;
        }

        public static IList<IHaveCustomMapping> LoadCustomMappings(Assembly rootAssembly)
        {
            var types = rootAssembly.GetExportedTypes();

            var mapsFrom = (from type in types
                            from instanse in type.GetInterfaces()
                            where
                                 typeof(IHaveCustomMapping).IsAssignableFrom(type) &&
                                 !type.IsAbstract &&
                                 !type.IsInterface
                            select (IHaveCustomMapping)Activator.CreateInstance(type)).ToList();

            return mapsFrom;

        }


    }
}
