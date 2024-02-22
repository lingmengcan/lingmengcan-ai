# 大模型AI应用平台 lingmengcan-ai

lingmengcan-ai 是一个基于大模型的ai系统，目前提供对话和后台角色管理。本平台使用的技术栈，包括Vue 3、Naive UI和Tailwind CSS构建UI层，以及NestJS、LangChainJS和MySQL为服务层

## 特点

- **对话**: 支持与大型语言模型进行高效、自然的对话交互。
- **角色管理**: 包含一个完整的后台角色管理模块，便于用户管理和权限控制。
- **AIGC功能**: 后续完善。
- **推理和训练**: 后续完善。

## 技术栈

- **UI层**: Vue 3、Naive UI、Tailwind CSS
- **服务层**: NestJS、LangChainJS、MySQL

## 快速开始

### 环境要求

确保您的开发环境满足以下要求：

- Node.js 版本 12.x 或更高
- MySQL 版本 5.7 或更高

### 安装

克隆项目到本地：

```bash
git clone <项目仓库URL>
cd <项目目录>

安装依赖：

# 安装前端依赖
cd frontend
npm install

# 安装后端依赖
cd ../backend
npm install

运行
启动前端开发服务器：

cd frontend
npm run serve

启动后端服务：

cd backend
npm run start

现在，您可以通过访问 http://localhost:8080 来体验lingmengcan-ai。

贡献
我们欢迎所有形式的贡献，无论是小的文档修正还是新功能的提议。请阅读我们的贡献指南了解如何开始。

许可证
本项目采用 MIT 许可证。