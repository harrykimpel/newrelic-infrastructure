$computername = $env:computername
echo $computername
$HOSTNAME = $computername
$FILEPATH = "C:\Program Files\New Relic\newrelic-infra\integrations.d\mssql-config.yml"
$SQLINSTANCES = Get-ChildItem -Path "SQLSERVER:\SQL\$HOSTNAME"

$content = "integration_name: com.newrelic.mssql`r`n"
$content = $content + "`r`n"
$content = $content + "instances:`r`n"

Foreach ( $inst in $SQLINSTANCES ) {
    echo $inst
    $instanceName = "" + $inst
    $instanceName = $instanceName.Replace("[", "")
    $instanceName = $instanceName.Replace("]", "")
    $instanceNameRaw = $instanceName
    $instanceNameRaw = $instanceNameRaw.Replace($HOSTNAME, "")
    $instanceNameRaw = $instanceNameRaw.Replace("\", "")
    $instanceName = $instanceName.Replace("\", "--")
    $content = $content + "  - name: $instanceName`r`n"
    $content = $content + "    command: all_data`r`n"
    $content = $content + "    arguments:`r`n"
    $content = $content + "      hostname: $HOSTNAME`r`n"
    $content = $content + "      username: newrelic`r`n"
    $content = $content + "      password: password`r`n"
    $content = $content + "      `r`n"
    $content = $content + "      # Both port and instance can be omitted to use a default port of 1433`r`n"
    $content = $content + "      #port: <Microsoft SQL Server port to connect to. Only needed when instance not specified>`r`n"
    $content = $content + "      `r`n"
    $content = $content + "      # Only use instance instead of port if SQL Browser is enabled`r`n"
    if ($instanceName -eq $HOSTNAME) {
        $content = $content + "      instance: `r`n"
    }
    else {
        $content = $content + "      instance: $instanceNameRaw`r`n"
    }
    $content = $content + "      `r`n"
    $content = $content + "      enable_ssl: false`r`n"
    $content = $content + "      #trust_server_certificate: <true or false. If true server certificate is not verified for SSL. If false certificate will be verified against supplied certificate>`r`n"
    $content = $content + "      #certificate_location: <Location of the SSL Certificate. Do not specify if trust_server_certificate is set to true>`r`n"
    $content = $content + "      timeout: 0`r`n"
    $content = $content + "      #custom_metrics_query: >-`r`n"
    $content = $content + "      #   Select `r`n"
    $content = $content + "      #     t.text AS metric_name, from (SELECT * FROM sys.dm_exec_requests where sql_handle is not null) a CROSS APPLY  sys.dm_exec_sql_text(a.sql_handle) t `r`n"
    $content = $content + "      #   Select `r`n"
    $content = $content + "      #     'running_stored_procedures' AS metric_name,`r`n"
    $content = $content + "      #     t.text AS metric_value,`r`n"
    $content = $content + "      #     'attribute' as metric_type,`r`n"
    $content = $content + "      #     database_id`r`n"
    $content = $content + "      #   from (SELECT * FROM sys.dm_exec_requests where sql_handle is not null) a CROSS APPLY  sys.dm_exec_sql_text(a.sql_handle) t `r`n"
    $content = $content + "    labels:`r`n"
    $content = $content + "      env: production`r`n"
    $content = $content + "      role: mssql`r`n"
    $date = Get-Date
    $content = $content + "      datetime: $date`r`n"
}

#echo $content
New-Item -Path $FILEPATH -ItemType File -Force
Set-Content -Path $FILEPATH -Value $content

#Stop-Service -Name "newrelic-infra"
#Start-Service -Name "newrelic-infra"
Restart-Service newrelic-infra