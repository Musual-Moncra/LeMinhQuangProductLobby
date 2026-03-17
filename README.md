# 🏯 LeQuangMinhProduct - Lobby System

<div align="center">
  <img src="https://img.shields.io/badge/Roblox-Powered-00A2FF?style=for-the-badge&logo=roblox&logoColor=white" />
  <img src="https://img.shields.io/badge/Rojo-v7.7.0--rc.1-D32F2F?style=for-the-badge&logo=rojo&logoColor=white" />
  <img src="https://img.shields.io/badge/Status-Development-orange?style=for-the-badge" />
</div>

---

### 🌟 Giới Thiệu
Đây là sản phẩm thương mại cá nhân cao cấp được phát triển bởi **LeQuangMinh**. Lobby System được thiết kế tối ưu cho hiệu năng, dễ dàng mở rộng và quản lý thông qua cấu trúc framework hiện đại.

### 🚀 Tính Năng Nổi Bật
- **Framework Loader Thông Minh:** Tự động load module theo thứ tự ưu tiên (`Order`), giúp quản lý vòng đời logic game dễ dàng.
- **Hệ Thống Remotes Tự Động:** Khởi tạo `RemoteEvent`, `RemoteFunction` tự động từ cấu hình, giúp code sạch sẽ và chuyên nghiệp.
- **Cấu Trúc Rojo Chuẩn:** Phân chia rõ ràng giữa `Shared`, `Server`, và `Client`.
- **Dễ Dàng Tích Hợp:** Thiết kế theo dạng module-based, hỗ trợ bảo trì và cập nhật nhanh chóng.

### 🛠️ Kỹ Thuật Sử Dụng
- **Language:** Luau (Roblox)
- **Tooling:** Rojo, VS Code, Github
- **Architecture:** Module-Driven Architecture

### 📁 Cấu Trúc Source Code
```text
src
├── ReplicatedStorage
│   └── Modules
│       ├── Config         # Cấu hình hệ thống (Remotes, GameData)
│       └── Shared         # Framework Loader, Utilities
├── ServerScriptService
│   └── ServerMain.server.lua  # Entry point của Server
└── ServerStorage
    └── Server             # Logic xử lý phía Server
```

---

### 📝 Ghi Chú Bản Quyền
> [!IMPORTANT]
> Đây là sản phẩm thương mại cá nhân của **LeQuangMinh**. Vui lòng không sao chép hoặc phân phối lại khi chưa có sự đồng ý của tác giả.

---
<div align="center">
  <sub>Xây dựng với ❤️ bởi Musual</sub>
</div>