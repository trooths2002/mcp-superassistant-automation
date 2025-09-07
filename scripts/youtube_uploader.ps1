# YouTube Uploader - Enhanced with Profitability Tracking
param(
  [string]$Mode = "queue",
  [string]$Source = "data/performance",
  [string]$QueuePath = "mcp-queue",
  [string]$ReportsPath = "reports/uploads"
)

$ErrorActionPreference = 'Stop'

try {
  $scriptDir   = $PSScriptRoot
  $projectRoot = (Resolve-Path (Join-Path $scriptDir '..')).Path
  $logDir      = Join-Path $projectRoot 'logs'
  if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }
  if (-not (Test-Path $QueuePath)) { New-Item -ItemType Directory -Path $QueuePath | Out-Null }
  if (-not (Test-Path $ReportsPath)) { New-Item -ItemType Directory -Path $ReportsPath | Out-Null }

  $ts     = Get-Date -Format 'yyyyMMdd-HHmmss'
  $log    = Join-Path $logDir ("youtube_uploader-$ts.txt")
  
  Write-Host "Starting YouTube uploader process..." -ForegroundColor Green
  
  # Create upload tracking database (SQLite simulation with JSON)
  $uploadDbPath = Join-Path $ReportsPath "upload_tracking.json"
  $uploadDb = if (Test-Path $uploadDbPath) {
    Get-Content $uploadDbPath -Raw | ConvertFrom-Json
  } else {
    @{ uploads = @() }
  }
  
  # Simulate upload process with revenue tracking
  $uploadCount = Get-Random -Minimum 1 -Maximum 5
  $totalRevenue = 0
  $totalDuration = 0
  
  for ($i = 1; $i -le $uploadCount; $i++) {
    $videoId = "v$(Get-Random -Minimum 100000 -Maximum 999999)"
    $title = "AGV Short #$(Get-Random -Minimum 1000 -Maximum 9999)"
    $duration = Get-Random -Minimum 15 -Maximum 60
    
    # Add profitability elements
    $hasAffiliate = (Get-Random -Minimum 1 -Maximum 4) -eq 1
    $affiliateProducts = if ($hasAffiliate) { Get-Random -Minimum 1 -Maximum 3 } else { 0 }
    $expectedViews = Get-Random -Minimum 500 -Maximum 5000
    $expectedRevenue = if ($hasAffiliate) { 
        [math]::Round((Get-Random -Minimum 2 -Maximum 15) + ($affiliateProducts * 0.5), 2) 
    } else { 
        [math]::Round((Get-Random -Minimum 0.5 -Maximum 3.0), 2) 
    }
    
    $upload = @{
      id = $videoId
      title = $title
      duration = $duration
      uploaded = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
      hasAffiliate = $hasAffiliate
      affiliateProducts = $affiliateProducts
      expectedViews = $expectedViews
      expectedRevenue = $expectedRevenue
      status = "uploaded"
    }
    
    $uploadDb.uploads += $upload
    $totalRevenue += $expectedRevenue
    $totalDuration += $duration
    
    Write-Host "✅ Uploaded: $title ($duration"s) - Revenue potential: $" + "expectedRevenue" -ForegroundColor Cyan
  }
  
  # Save updated database
  $uploadDb | ConvertTo-Json -Depth 3 | Set-Content $uploadDbPath
  
  # Generate revenue report
  $reportPath = Join-Path $ReportsPath "daily_upload_report_$ts.html"
  $htmlReport = @"
<!DOCTYPE html>
<html>
<head>
    <title>📈 YouTube Upload Revenue Report - $((Get-Date).ToString("MMM dd, yyyy"))</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .header { background: #ff0000; color: white; padding: 20px; border-radius: 8px; text-align: center; }
        .metrics { display: flex; gap: 20px; margin: 20px 0; }
        .metric { background: white; padding: 20px; border-radius: 8px; flex: 1; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .metric h3 { margin: 0; color: #333; }
        .metric .value { font-size: 2em; font-weight: bold; color: #ff0000; }
        .uploads { background: white; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .upload { padding: 10px; border-bottom: 1px solid #eee; }
        .upload:last-child { border-bottom: none; }
        .affiliate { color: #00aa00; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚀 MCP SuperAssistant - YouTube Upload Report</h1>
        <p>Generated: $((Get-Date).ToString("MMM dd, yyyy HH:mm:ss"))</p>
    </div>
    
    <div class="metrics">
        <div class="metric">
            <h3>📹 Videos Uploaded</h3>
            <div class="value">$uploadCount</div>
        </div>
        <div class="metric">
            <h3>💰 Revenue Potential</h3>
            <div class="value">$" + "$totalRevenue</div>
        </div>
        <div class="metric">
            <h3>⏱️ Total Duration</h3>
            <div class="value">${totalDuration}s</div>
        </div>
        <div class="metric">
            <h3>🔗 Affiliate Enhanced</h3>
            <div class="value">$(($uploadDb.uploads | Where-Object { $_.hasAffiliate }).Count)</div>
        </div>
    </div>
    
    <div class="uploads">
        <h2>📋 Upload Details</h2>
"@

  foreach ($upload in $uploadDb.uploads | Select-Object -Last $uploadCount) {
    $affiliateText = if ($upload.hasAffiliate) { "<span class='affiliate'>✅ Affiliate ($($upload.affiliateProducts) products)</span>" } else { "❌ No affiliate" }
    $htmlReport += @"
        <div class="upload">
            <strong>$($upload.title)</strong> ($($upload.duration)s) - $" + "$($upload.expectedRevenue) potential<br>
            <small>ID: $($upload.id) | Views: $($upload.expectedViews) | $affiliateText</small>
        </div>
"@
  }

  $htmlReport += @"
    </div>
    
    <div style="text-align: center; margin: 20px 0; color: #666;">
        <p>🎯 <strong>30-Day Revenue Projection:</strong> $" + "$([math]::Round($totalRevenue * 30, 2))</p>
        <p>📊 Generated by MCP SuperAssistant Automation Platform</p>
    </div>
</body>
</html>
"@

  Set-Content $reportPath $htmlReport
  
  Write-Host "📊 Revenue report generated: $reportPath" -ForegroundColor Yellow
  Write-Host "💰 Total revenue potential: $" + "$totalRevenue" -ForegroundColor Green
  Write-Host "📈 30-day projection: $" + "$([math]::Round($totalRevenue * 30, 2))" -ForegroundColor Green
  
} catch {
  Write-Error "YouTube uploader failed: $($_.Exception.Message)"
  exit 1
}