# please add your connection string and query
## remove placeholder query

$cn2 = new-object system.data.SqlClient.SQLConnection("Data Source=servername;Database=YourCause;UID=username;PWD=password");
$Command = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection = $cn2
$Command.CommandText = "select top 1 * from [table]";
$cn2.Open()
$result = $Command.ExecuteReader()
$table = New-Object System.Data.DataTable

while ($result.Read()) {
     Write-Host $result.GetValue(0)

    }
$table.Load($result)

$cn2.Close();