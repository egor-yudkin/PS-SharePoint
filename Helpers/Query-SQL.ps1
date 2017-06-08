<#
.Synopsis
   Runs the SELECT query on the SQL server.
.DESCRIPTION
   Runs the SELECT query on the SQL server. Returns a DataSet object.
.EXAMPLE
   Query-SQL -QueryText "SELECT COUNT(*) FROM TABLE1" -ServerName "SQLServer1" -DatabaseName "DB1" 
#>

function Query-SQL
{
    [OutputType([System.Data.DataSet])]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({($_ -match "SELECT")})]
        [string]$QueryText,
        
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$ServerName,
        
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$DatabaseName
    )

    $ConnectionTimeout = 30

    $QueryTimeout = 120

    $conn=new-object System.Data.SqlClient.SQLConnection
    if ($DatabaseName)
    {
        $ConnectionString = "Server={0};Database={1};Integrated Security=True;Connect Timeout={2}" -f $ServerName,$DatabaseName,$ConnectionTimeout
    }
    else
    {
        $ConnectionString = "Server={0};Integrated Security=True;Connect Timeout={1}" -f $ServerName,$ConnectionTimeout
    }
    $conn.ConnectionString=$ConnectionString
    $conn.Open() | Out-Null
    $cmd=new-object system.Data.SqlClient.SqlCommand($QueryText,$conn)
    $cmd.CommandTimeout=$QueryTimeout
    $ds=New-Object system.Data.DataSet
    $da=New-Object system.Data.SqlClient.SqlDataAdapter($cmd)
    $da.fill($ds) | Out-Null
    $conn.Close()
    return $ds
}