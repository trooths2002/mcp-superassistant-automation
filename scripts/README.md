# MCP SuperAssistant Automation Scripts

This directory contains the core PowerShell automation scripts that power the 9 daily business processes.

## 📜 **Script Overview**

### **Core Automation Tasks**
- `alerts_digest.ps1` - Daily alerts compilation and notification system
- `analytics_builder.ps1` - Performance metrics and analytics generation  
- `business_intelligence_update.ps1` - BI data processing and dashboard updates
- `content_pipeline_check.ps1` - Content queue monitoring and optimization
- `doc_index_refresh.ps1` - Document indexing and search capability updates
- `intelligence_builder.ps1` - Business intelligence compilation and reporting
- `youtube_uploader.ps1` - YouTube automation with revenue tracking integration

### **Queue Workers**
- `media_queue_worker_evening.ps1` - Evening content processing pipeline
- `media_queue_worker_night.ps1` - Night batch processing for media content

### **Setup & Management**
- `Install-Tasks-From-Manifest.ps1` - Windows Task Scheduler registration system
- `Test-Manifest.ps1` - Configuration validation and testing utilities

## 🚀 **Usage**

Individual scripts can be run directly:
```powershell
# Run specific automation task
.\scripts\youtube_uploader.ps1

# Install all scheduled tasks  
.\scripts\Install-Tasks-From-Manifest.ps1 -ManifestPath ".\ops\orchestrators\scheduler\tasks.json"
```

Or execute the complete suite:
```batch
# Run all 9 tasks in sequence
.\Run-MCP-Daily-Automation.bat
```

## 💰 **Revenue Tracking**

The `youtube_uploader.ps1` script includes comprehensive revenue tracking:
- Affiliate product integration
- Upload performance monitoring
- Revenue projection calculations
- HTML report generation

## 📊 **Logging & Monitoring**

All scripts generate timestamped logs in the `logs/` directory for:
- Execution tracking
- Error diagnostics  
- Performance monitoring
- Revenue analysis

---

These scripts represent the automation backbone of the MCP SuperAssistant platform, providing enterprise-grade business process automation.