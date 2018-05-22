using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LMS.UserControl
{
    public partial class ProductCardControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Handles image src logic
        protected string RenderImage(object imgUrl)
        {
            string path = imgUrl as string;

            // Get all png and jpg files in current dir only
            var images = Directory.GetFiles(Server.MapPath(path) ?? throw new InvalidOperationException(), "*", SearchOption.TopDirectoryOnly)
                .Where(file => file.EndsWith(".png") || file.EndsWith(".jpg") || file.EndsWith(".jpeg"));

            // Resolve physical paths to server-relative paths
            List<string> files = images.Select(img => path + "/" + Path.GetFileName(img)).ToList();
            return files[0];
        }

        protected bool IsAvailable(object itemCount)
        {
            int count = (int)itemCount;

            if (count == 0) return false;
            return true;
        }
    }
}