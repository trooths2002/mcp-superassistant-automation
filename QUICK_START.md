# 🚀 MCP SuperAssistant Quick Start Guide

## ⚡ **One-Command Setup**

```powershell
# Complete setup and launch
git clone https://github.com/trooths2002/mcp-superassistant-automation.git
cd mcp-superassistant-automation
npm install
.\Run-MCP-Daily-Automation.bat
```

## 🎯 **Daily Operations**

### **Start Full Automation Suite**

```powershell
.\Run-MCP-Daily-Automation.bat
```

### **Launch MCP Proxy for Browser Extension**

```powershell
npx @srbhptl39/mcp-superassistant-proxy@latest --config ./config.json --outputTransport sse
```

### **Register All Scheduled Tasks**

```powershell
.\scripts\Install-Tasks-From-Manifest.ps1 -ManifestPath ".\ops\orchestrators\scheduler\tasks.json"
```

## 📊 **Monitor Results**

- **Revenue Reports**: `reports/uploads/daily_upload_report_*.html`
- **Automation Logs**: Check `logs/` directory
- **Business Intelligence**: `reports/business-intelligence/`

## ⚙️ **Configuration**

### **MCP Servers Configuration**

Edit `config.json` to modify server settings:

```json
{
  "mcpServers": {
    "scheduler": {
      "command": "node",
      "args": ["servers/scheduler/index.js"]
    }
  }
}
```

### **Task Scheduling**

Edit `ops/orchestrators/scheduler/tasks.json` to modify automation tasks:

```json
{
  "name": "youtube_uploader",
  "schedule": "16:00",
  "enabled": true
}
```

## 🔧 **Troubleshooting**

### **Browser Extension Issues**

1. Ensure MCP proxy is running on port 3006
2. Check Chrome extension is loaded and enabled
3. Verify `config.json` configuration

### **Automation Failures**

1. Check logs in `logs/` directory
2. Verify PowerShell execution policy: `Set-ExecutionPolicy RemoteSigned`
3. Ensure all dependencies installed: `npm install`

### **Revenue Tracking Issues**

1. Verify YouTube uploader configuration
2. Check affiliate product database
3. Review upload tracking logs

## 🎉 **Success Indicators**

✅ **MCP Proxy Running**: Port 3006 accessible
✅ **Browser Extension Active**: Sidebar appears on MCP UI
✅ **Automation Suite**: All 9 tasks execute successfully  
✅ **Revenue Tracking**: Upload reports generate properly
✅ **Business Intelligence**: Reports update automatically

## 📞 **Support**

- **Documentation**: Check `PROJECT_STRUCTURE.md`
- **Issues**: Review logs in `logs/` directory
- **Configuration**: Verify `config.json` settings
- **GitHub Issues**: Create issue for bugs/features

---

**🚀 Ready to scale your automation? This platform provides enterprise-grade task automation with revenue tracking capabilities.**