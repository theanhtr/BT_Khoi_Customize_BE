using System.Text.Json;
using System.Text.Json.Serialization;

namespace MISA.WebFresher052023.CTM
{
    public class LocalTimeZoneConverter : JsonConverter<DateTime>
    {
        public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var valueStr = reader.GetString();
            var valueStrArray = valueStr.Split("/");
            
            if (valueStrArray.Length != 3 )
            {
                return DateTime.Parse(valueStr);

            }
            else
            {
                var readerStr = valueStrArray[1] + "/" + valueStrArray[0] + "/" + valueStrArray[2];
                return DateTime.Parse(readerStr);
            }
        }

        public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options)
        {
            if (value.Kind == DateTimeKind.Unspecified)
            {
                writer.WriteStringValue(DateTime.SpecifyKind(value, DateTimeKind.Local));
            } 
            else
            {
                writer.WriteStringValue(value);
            }
        }
    }
}
