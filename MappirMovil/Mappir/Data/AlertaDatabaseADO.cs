using System;
using System.Linq;
using System.Collections.Generic;

using Mono.Data.Sqlite;
using System.IO;
using System.Data;

namespace Mappir
{
	/// <summary>
	/// TaskDatabase uses ADO.NET to create the [Items] table and create,read,update,delete data
	/// </summary>
	public class AlertaDatabase 
	{
		static object locker = new object ();

		public SqliteConnection connection;

		public string path;

		/// <summary>
		/// Initializes a new instance of the <see cref="Tasky.DL.TaskDatabase"/> TaskDatabase. 
		/// if the database doesn't exist, it will create the database and all the tables.
		/// </summary>
		public AlertaDatabase (string dbPath) 
		{
			var output = "";
			path = dbPath;
			// create the tables
			bool exists = File.Exists (dbPath);

			if (!exists){

				connection = new SqliteConnection ("Data Source=" + dbPath);

				connection.Open ();
				var commands = new[] {
					"CREATE TABLE [Items] (_id INTEGER PRIMARY KEY ASC, Type INTEGER, Title NTEXT, Latitude DOUBLE,Longitude DOUBLE,Image NTEXT);"
				};
				 
				foreach (var command in commands) {
					using (var c = connection.CreateCommand ()) {
						c.CommandText = command;
						//var i =
							c.ExecuteNonQuery ();
						 
					}
				}
			} else {
				// already exists, do nothing. 
			}
			Console.WriteLine (output);
		}

		/// <summary>Convert from DataReader to Task object</summary>
		Alerta  FromReader (SqliteDataReader r) {

			var t = new Alerta ();
			 t.ID = Convert.ToInt32 (r ["_id"]);
			 t.Type = Convert.ToInt32 (r ["Type"]);  
			 t.Title = r ["Title"].ToString();
			 t.Latitude  = Convert.ToDouble(r["Latitude"]);
			 t.Longitude =Convert.ToDouble (r["Longitude"]);
			 t.Image = r ["Image"].ToString();
			 
			return t;
		}

		public IEnumerable<Alerta> GetItems ()
		{
			var tl = new List<Alerta> ();

			lock (locker){
				connection = new SqliteConnection ("Data Source=" + path);
				connection.Open ();
				using (var contents = connection.CreateCommand ()) {
					contents.CommandText = "SELECT [_id], [Type], [Title], [Latitude],[Longitude],[Image] from [Items]";
					var r = contents.ExecuteReader ();
					while (r.Read ()) {
						tl.Add (FromReader(r));
					}
				}
				connection.Close ();
			}
			return tl;
		}

		public Alerta GetItem (int id) 
		{
			var t = new Alerta ();
			lock (locker) {
				connection = new SqliteConnection ("Data Source=" + path);
				connection.Open ();
				using (var command = connection.CreateCommand ()) {
					command.CommandText = "SELECT [_id], [Type], [Title], [Latitude],[Longitude],[Image] WHERE [_id] = ?";
					command.Parameters.Add (new SqliteParameter (DbType.Int32) { Value = id });
					var r = command.ExecuteReader ();
					while (r.Read ()) {
						t = FromReader (r);
						break;
					}
				}
				connection.Close ();
			}
			return t;
		}

		public int SaveItem (Alerta  item) 
		{
			int r;
			lock (locker) {
				if (item.ID != 0) {
					connection = new SqliteConnection ("Data Source=" + path);
					connection.Open ();
					using (var command = connection.CreateCommand ()) {
						command.CommandText = "UPDATE [Items] SET [Type] = ?, [Title] = ?, [Latitude] = ?, [Longitude] = ?, [Image] = ? WHERE [_id] = ?;";
						command.Parameters.Add (new SqliteParameter (DbType.Int32) { Value = item.Type });
						command.Parameters.Add (new SqliteParameter (DbType.String) { Value = item.Title });
						command.Parameters.Add (new SqliteParameter (DbType.Double) { Value = item.Latitude });
						command.Parameters.Add (new SqliteParameter (DbType.Double) { Value = item.Longitude });
						command.Parameters.Add (new SqliteParameter (DbType.String) { Value = item.Image }); 
						command.Parameters.Add (new SqliteParameter (DbType.Int32) { Value = item.ID });
						r = command.ExecuteNonQuery ();
					}
					connection.Close ();
					return r;
				} else {
					connection = new SqliteConnection ("Data Source=" + path);
					connection.Open ();
					using (var command = connection.CreateCommand ()) {
						command.CommandText = "INSERT INTO [Items] ([Type], [Title], [Latitude], [Longitude], [Image]) VALUES (? ,?, ?, ?,?)";
						command.Parameters.Add (new SqliteParameter (DbType.Int32) { Value = item.Type });
						command.Parameters.Add (new SqliteParameter (DbType.String) { Value = item.Title });
						command.Parameters.Add (new SqliteParameter (DbType.Double) { Value = item.Latitude });
						command.Parameters.Add (new SqliteParameter (DbType.Double) { Value = item.Longitude });
						command.Parameters.Add (new SqliteParameter (DbType.String) { Value = item.Image });

						r = command.ExecuteNonQuery ();
					}
					connection.Close ();
					return r;
				}

			}
		}

		public int DeleteItem(int id) 
		{
			lock (locker) {
				int r;
				connection = new SqliteConnection ("Data Source=" + path);
				connection.Open ();
				using (var command = connection.CreateCommand ()) {
					command.CommandText = "DELETE FROM [Items] WHERE [_id] = ?;";
					command.Parameters.Add (new SqliteParameter (DbType.Int32) { Value = id});
					r = command.ExecuteNonQuery ();
				}
				connection.Close ();
				return r;
			}
		}
	}
}