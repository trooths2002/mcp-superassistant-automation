@echo off
REM MCP Daily Automation Runner
REM Runs all 9 MCP automation tasks in sequence

echo 🚀 Starting MCP Daily Automation Suite...
echo Generated: %date% %time%
echo.

REM Create timestamp for logs
set timestamp=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%

echo ⏰ 08:00 - Running Alerts Digest...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\alerts_digest.ps1" > "logs\alerts_digest_%timestamp%.log" 2>&1

echo ⏰ 09:00 - Running Intelligence Builder...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\intelligence_builder.ps1" > "logs\intelligence_builder_%timestamp%.log" 2>&1

echo ⏰ 10:00 - Running Analytics Builder...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\analytics_builder.ps1" > "logs\analytics_builder_%timestamp%.log" 2>&1

echo ⏰ 13:00 - Running Document Index Refresh...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\doc_index_refresh.ps1" > "logs\doc_index_refresh_%timestamp%.log" 2>&1

echo ⏰ 14:30 - Running Business Intelligence Update...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\business_intelligence_update.ps1" > "logs\business_intelligence_update_%timestamp%.log" 2>&1

echo ⏰ 16:00 - Running Content Pipeline Check...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\content_pipeline_check.ps1" > "logs\content_pipeline_check_%timestamp%.log" 2>&1

echo ⏰ 20:00 - Running Evening Media Queue Worker...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\media_queue_worker_evening.ps1" > "logs\media_queue_worker_evening_%timestamp%.log" 2>&1

echo ⏰ 02:00 - Running Night Media Queue Worker...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\media_queue_worker_night.ps1" > "logs\media_queue_worker_night_%timestamp%.log" 2>&1

echo ⏰ 08:00 - Running YouTube Uploader...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\youtube_uploader.ps1" > "logs\youtube_uploader_%timestamp%.log" 2>&1

echo.
echo ✅ MCP Daily Automation Suite Complete!
echo 📊 Check reports\ directory for generated reports
echo 📝 Check logs\ directory for execution logs
echo 💰 Revenue tracking active in reports\uploads\
echo.
pause