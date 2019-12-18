[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "EXE FILE" # Link to exe file that should be launched.
$destination = "C:\Users\$envVar\AppData\Roaming\$filename"
$envVar = Get-ChildItem env:username | Select -ExpandProperty "value"
$filename = "UNIV_5.585.13.0_PS_x64.exe"

function runProgram
{
    Start-Process -FilePath $destination -Wait
}

If ([System.IO.File]::Exists("C:\Users\$envVar\AppData\Roaming\$filename")) {
    echo "File found, proceeding to installation!"
    runProgram
}
Else
{
    $start_time = Get-Date
    Write-Output "Download started!"
    (new-object System.Net.Webclient).DownloadFile($url, $destination)

    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) secound(s)"
    runProgram
}
