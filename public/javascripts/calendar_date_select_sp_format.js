_translations = {
    "OK": "OK",
    "Now": "Ahora",
    "Today": "Hoy"
  }

Date.weekdays = $w("D L M X J V S");

Date.months = $w("Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Deciembre" );


Date.prototype.toFormattedString = function(include_time)
{
	var str = Date.padded2(this.getDate()) + "/" + Date.padded2(this.getMonth() + 1) + "/" + this.getFullYear();
  return str;
}

Date.parseFormattedString = function(string) 
{
  // Implement me
}