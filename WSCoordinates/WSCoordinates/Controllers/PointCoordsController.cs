using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;
using WSCoordinates.Models;

namespace WSCoordinates.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class CoordsController : ApiController
    {
        private GeoDBEntities db = new GeoDBEntities();

        // GET: api/PointCoords
        public IQueryable<PointCoord> GetCoords(string User, string Pass)
        {
            if (User == "Admin" && Pass == "Admin123#")
                return db.PointCoords;
            else return null;
        }

        // POST: api/PointCoords
        [ResponseType(typeof(PointCoord))]
        public IHttpActionResult PostCoord(PointCoord pointCoord)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.PointCoords.Add(pointCoord);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = pointCoord.ID }, pointCoord);
        }
    }
}