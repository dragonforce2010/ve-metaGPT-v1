# MetaGPT 开发指南

本文档提供了使用 UV 进行 MetaGPT 项目开发的完整指南。

## 环境要求

- Python 3.12 或更高版本（推荐 3.12.x）
- [UV](https://github.com/astral-sh/uv) 包管理器
- Node.js 和 pnpm（用于前端相关功能）

## 快速开始

### 1\. 安装 UV

```bash
# 使用官方安装脚本（推荐）
curl -LsSf https://astral.sh/uv/install.sh | sh

# 或者使用 homebrew (macOS)
brew install uv

# 或者使用 pip
pip install uv
```

### 2\. 克隆项目并设置环境

```bash
# 克隆项目
git clone <repository-url>
cd MetaGPT

# 运行自动化设置脚本
chmod +x setup_dev.sh
./setup_dev.sh
```

### 3\. 激活开发环境

```bash
# 方法1：使用激活脚本
source activate_env.sh

# 方法2：手动激活
source .venv/bin/activate

# 方法3：使用 uv run（推荐）
uv run python your_script.py
```

## 项目结构

```
MetaGPT/
├── pyproject.toml          # 项目配置和依赖定义
├── uv.lock                 # 锁定的依赖版本（自动生成）
├── requirements.txt        # 传统格式的依赖文件（与 pyproject.toml 同步）
├── setup_dev.sh           # 开发环境设置脚本
├── activate_env.sh        # 环境激活脚本
├── UV_USAGE.md           # UV 使用指南
├── DEVELOPMENT.md        # 本文档
└── .venv/                # 虚拟环境（自动创建）
```

## 常用开发命令

### 依赖管理

```bash
# 安装所有依赖
uv sync

# 添加新的生产依赖
uv add requests

# 添加开发依赖
uv add --dev pytest black flake8

# 添加可选依赖组
uv add --optional android_assistant tensorflow

# 移除依赖
uv remove requests

# 更新依赖
uv update
uv update requests  # 更新特定包

# 查看依赖树
uv tree

# 导出依赖到 requirements.txt
uv export --format requirements-txt > requirements.txt
```

### 项目运行

```bash
# 在虚拟环境中运行 Python 脚本
uv run python examples/di/crawl_webpage.py

# 运行测试
uv run pytest
uv run pytest tests/specific_test.py

# 运行 MetaGPT 命令
uv run metagpt "Create a 2048 game"

# 运行特定模块
uv run python -m metagpt.roles.architect
```

### 代码质量

```bash
# 格式化代码
uv run black .
uv run isort .

# 类型检查
uv run mypy metagpt/

# 代码检查
uv run flake8 metagpt/
uv run pylint metagpt/
```

## 开发工作流

### 1\. 开始新功能开发

```bash
# 创建新分支
git checkout -b feature/new-feature

# 确保环境是最新的
uv sync

# 开始开发
uv run python your_development_script.py
```

### 2\. 添加新依赖

```bash
# 添加依赖
uv add new-package

# 运行测试确保兼容性
uv run pytest

# 更新 requirements.txt
uv export --format requirements-txt > requirements.txt

# 提交更改
git add pyproject.toml uv.lock requirements.txt
git commit -m "Add new-package dependency"
```

### 3\. 运行测试

```bash
# 运行所有测试
uv run pytest

# 运行特定测试文件
uv run pytest tests/test_specific.py

# 运行带覆盖率的测试
uv run pytest --cov=metagpt --cov-report=html

# 运行特定标记的测试
uv run pytest -m "not slow"
```

### 4\. 构建和发布

```bash
# 构建项目
uv build

# 安装到本地进行测试
uv pip install -e .

# 检查构建结果
ls dist/
```

## 常见问题解决

### 1\. 依赖冲突

```bash
# 清理并重新安装
rm -rf .venv uv.lock
uv sync

# 或者强制更新
uv lock --upgrade
uv sync
```

### 2\. Python 版本问题

```bash
# 检查可用的 Python 版本
uv python list

# 设置特定版本
uv python pin 3.12.3

# 重新创建环境
rm -rf .venv
uv sync
```

### 3\. 导入错误

```bash
# 确保项目以开发模式安装
uv pip install -e .

# 检查 Python 路径
uv run python -c "import sys; print(sys.path)"
```

## 性能优化

### 1\. 缓存配置

UV 会自动缓存下载的包，提高后续安装速度。缓存位置：

- macOS: `~/Library/Caches/uv`
- Linux: `~/.cache/uv`

### 2\. 并行安装

UV 默认并行安装依赖，比传统的 pip 快很多。

### 3\. 预编译轮子

UV 优先使用预编译的轮子，减少编译时间。

## 与传统工具的对比

| 功能 | UV | pip + venv | Poetry |
| --- | --- | --- | --- |
| 安装速度 | 🚀 极快 | 🐌 慢 | 🚶 中等 |
| 依赖解析 | ✅ 快速 | ❌ 慢 | ✅ 好 |
| 锁文件 | ✅ uv.lock | ❌ 无 | ✅ poetry.lock |
| 虚拟环境 | ✅ 自动 | 🔧 手动 | ✅ 自动 |
| 项目管理 | ✅ 完整 | ❌ 基础 | ✅ 完整 |

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 使用 UV 管理依赖
4. 运行测试确保通过
5. 提交 Pull Request

## 更多资源

- [UV 官方文档](https://docs.astral.sh/uv/)
- [MetaGPT 文档](https://docs.deepwisdom.ai/)
- [Python 包管理最佳实践](https://packaging.python.org/)

---

如有问题，请查看 [UV_USAGE.md](./UV_USAGE.md) 或提交 Issue