using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ControlsSample.Models
{
    public interface ISampleDataRepository
    {
        /// <summary>
        /// Gets the root.
        /// </summary>
        /// <returns></returns>
        AreaDivide GetRoot();

        /// <summary>
        /// Gets the child area divide.
        /// </summary>
        /// <param name="pId">The p id.</param>
        /// <returns></returns>
        List<AreaDivide> GetChildAreaDivide(int pId);

        /// <summary>
        /// Gets the full area divide list.
        /// </summary>
        /// <returns></returns>
        List<AreaDivide> GetFullAreaDivideList();


        /// <summary>
        /// Queries the complete person.
        /// </summary>
        /// <param name="q">The key word.</param>
        /// <param name="limit">The limit.</param>
        /// <returns></returns>
        List<Person> QueryCompletePerson(string q,int limit);

        /// <summary>
        /// Queries all product.
        /// </summary>
        /// <param name="view">The view.</param>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        JsonFlexiGridData QueryAllProduct(PageView view,int categoryId);

        /// <summary>
        /// Queries all categories.
        /// </summary>
        /// <returns></returns>
        JsonFlexiGridData QueryAllCategories();
    }
}
